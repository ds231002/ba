import os
import time
from multiprocessing import Process, Queue
from dotenv import load_dotenv
from openai import OpenAI
# from pydantic import BaseModel

load_dotenv()

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",
)

client_openai = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

def _get_response_answer(response) -> str:
    return response.choices[0].message.content

def _get_response_input_tokens(response) -> int:
    return response.usage.prompt_tokens

def _get_response_output_tokens(response: dict) -> int:
    return response.usage.completion_tokens

def _get_response_total_tokens(response: dict) -> int:
    return response.usage.total_tokens

def _get_response_finish_reason(response: dict) -> str:
    return response.choices[0].finish_reason

def _call_llm_process(queue, user_prompt, system_prompt, model):
    if model == "gpt-5.4-mini-2026-03-17":
        client = client_openai

    try:
        response = client.chat.completions.create(
            model=model,
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_prompt}
            ],
            temperature=0,
        )

        queue.put({
            "success": True,
            "response": response
        })

    except Exception as e:
        queue.put({
            "success": False,
            "error": str(e)
        })


def generate_response(
    user_prompt: str,
    system_prompt: str,
    model: str,
    timeout: int = 120
) -> dict:

    start_time = time.perf_counter()

    queue = Queue()

    process = Process(
        target=_call_llm_process,
        args=(queue, user_prompt, system_prompt, model)
    )

    process.start()

    # Maximal timeout Sekunden warten
    process.join(timeout)

    elapsed_time = time.perf_counter() - start_time

    # Noch nicht fertig → sofort beenden
    if process.is_alive():
        process.kill()
        process.join()

        return {
            "answer": None,
            "finish_reason": "timeout",
            "usage": {
                "runtime_seconds": elapsed_time,
                "input_tokens": None,
                "output_tokens": None,
                "total_tokens": None
            }
        }

    # Prozess ist fertig
    if queue.empty():
        return {
            "answer": None,
            "finish_reason": "error",
            "usage": {
                "runtime_seconds": elapsed_time,
                "input_tokens": None,
                "output_tokens": None,
                "total_tokens": None
            }
        }

    result = queue.get()

    if not result["success"]:
        return {
            "answer": None,
            "finish_reason": "error",
            "usage": {
                "runtime_seconds": elapsed_time,
                "input_tokens": None,
                "output_tokens": None,
                "total_tokens": None
            },
            "error": result["error"]
        }

    response = result["response"]

    return {
        "answer": _get_response_answer(response),
        "finish_reason": _get_response_finish_reason(response),
        "usage": {
            "runtime_seconds": elapsed_time,
            "input_tokens": _get_response_input_tokens(response),
            "output_tokens": _get_response_output_tokens(response),
            "total_tokens": _get_response_total_tokens(response)
        }
    }