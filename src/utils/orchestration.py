from utils.create_system_prompts import (
    create_system_prompt_for_method_1,
    create_system_prompt_for_method_2,
    create_system_prompt_for_method_3
)
from utils.llm import generate_response
import json

def generate_result_for_task(
    task_id: str,
    task_type: str,
    task: str,
    method: str,
    model: str
):
    if method == "plan-based":
        system_prompt = create_system_prompt_for_method_2()
        response = generate_response(task, system_prompt, model)

        answer = json.loads(response["answer"])

        return {
            "task_id": task_id,
            "task_type": task_type,
            "task": task,
            "method": method,
            "model": model,
            "tool_calls": answer["plan"],
            "usage": response["usage"],
            "finish_reason": response["finish_reason"]
        }
    else:
        print(f"Method {method} nicht verfügbar.")