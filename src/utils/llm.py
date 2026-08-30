# import os
import time
from dotenv import load_dotenv
from openai import OpenAI
# from pydantic import BaseModel

load_dotenv()

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",
)

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

def generate_response(
    user_prompt: str,
    system_prompt: str,
    model: str,
    # timeout: int = 120
) -> dict:

    start_time = time.perf_counter()

    response = client.chat.completions.create(
        model=model,
        messages=[
            {
                "role": "system",
                "content": system_prompt
            },
            {
                "role": "user",
                "content": user_prompt
            }
        ],
        temperature=0,
    )

    elapsed_time = time.perf_counter() - start_time

    return {
        "answer": _get_response_answer(response),
        "finish_reason": _get_response_finish_reason(response),
        "usage": {
            "runtime_seconds": elapsed_time,
            "input_tokens": _get_response_input_tokens(response),
            "output_tokens": _get_response_output_tokens(response),
            "total_tokens": _get_response_total_tokens(response)
        },
    }