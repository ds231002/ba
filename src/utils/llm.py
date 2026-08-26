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

model = "qwen3:8b"

# def _generate_response(
#     user_prompt: str,
#     system_prompt: str,
#     model: str
# ) -> dict:
#     return client.chat.completions.create(
#         model=model,
#         messages=[
#             {
#                 "role": "system",
#                 "content": system_prompt
#             },
#             {
#                 "role": "user",
#                 "content": user_prompt
#             }
#         ],
#         temperature=0
#     )

def _get_response_answer(response) -> str:
    return response.choices[0].message.content

def _get_response_usage(response) -> dict:
    return {
        "input_tokens": response.usage.prompt_tokens,
        "output_tokens": response.usage.completion_tokens,
        "total_tokens": response.usage.total_tokens,
    }

def generate_response(
    user_prompt: str,
    system_prompt: str,
    model: str
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
        temperature=0
    )

    elapsed_time = time.perf_counter() - start_time

    return {
        "answer": response.choices[0].message.content,
        "usage": {
            "runtime_seconds": elapsed_time,
            "input_tokens": response.usage.prompt_tokens,
            "output_tokens": response.usage.completion_tokens,
            "total_tokens": response.usage.total_tokens
        },
        "model": model,
        "finish_reason": response.choices[0].finish_reason
    }