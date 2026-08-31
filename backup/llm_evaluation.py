import os
import time
from dotenv import load_dotenv
from openai import OpenAI
from pydantic import BaseModel
from utils.files import save_json
from utils.faiss import search_chunks

load_dotenv()

# openai
OPENAI_CLIENT = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
OPENAI_MODELS = {
    "large": "gpt-5.6-sol",
    "medium": "gpt-5.6-terra",
    "small": "gpt-5.6-luna",
}

# ollama
OLLAMA_CLIENT = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",
)
OLLAMA_MODEL = "qwen3:8b"

# selected
CLIENT = OLLAMA_CLIENT
MODEL = OLLAMA_MODEL

class Evaluation(BaseModel):
    category: str
    reason: str

SYSTEM_PROMPT = """
...
"""

def get_response(user_input: str):
    response = CLIENT.responses.parse(
        model=MODEL,
        input=[
            {"role": "system", "content": SYSTEM_PROMPT},
            {"role": "user", "content": user_input}
        ],
        text_format=Evaluation,
    )

    return response.output_parsed

def build_prompt(new_information: str, chunks: list[str]) -> str:
    prompt = f"Informationsinhalt:\n\n{new_information}\n\n"
    prompt += "Bereitgestellte Wissensabschnitte:\n\n"

    for i, chunk in enumerate(chunks, start=1):
        prompt += f"Abschnitt {i}\n{chunk}\n\n"

    return prompt

# sample for itrative use of get_response() with time

# def create_evaluation(
#     index,
#     chunks: list[str],
#     new_informations: list[str],
#     output_path: str,
#     next_k_chunks: int = 3
# ):
#     results = []
#     total = len(new_informations)
#     start_time = time.perf_counter()

#     for i, new_information in enumerate(new_informations, start=1):
#         iteration_start = time.perf_counter()

#         nearest_chunks = search_chunks(new_information, index, chunks, k=next_k_chunks)
#         prompt = build_prompt(new_information, chunks)
#         evaluation = get_response(prompt)

#         results.append({
#             "new_information": new_information,
#             "chunks": [
#                 {
#                     "text": chunk,
#                     "score": score,
#                 }
#                 for chunk, score in nearest_chunks
#             ],
#             "category": evaluation.category,
#             "reason": evaluation.reason,
#         })

#         iteration_time = time.perf_counter() - iteration_start
#         elapsed_time = time.perf_counter() - start_time
#         average_time = elapsed_time / i
#         remaining_time = average_time * (total - i)

#         print(
#             f"{i}/{total} | "
#             f"Durchlauf: {iteration_time:.1f}s | "
#             f"Gesamt: {elapsed_time:.1f}s | "
#             f"Rest: ~{remaining_time:.1f}s"
#         )

#     save_json(results, output_path)
#     print(f"Evaluation erfolgreich gespeichert: {output_path}")

#     return results