from utils.create_system_prompts import (
    create_system_prompt_for_method_1,
    create_system_prompt_for_method_2,
    create_system_prompt_for_method_3
)
from utils.llm import generate_response
from utils.files import load_json, save_json
from utils.tools import execute_tool_calls
import json
import matplotlib.pyplot as plt
import pandas as pd

def _save_result_as_json(
    result: dict,
    task_id: str,
    task_type: str,
    method: str,
    model: str
):
    path = f"output/results/{task_type}/{task_id}/{method}_{model.replace(':', '_')}.json"
    result_path = save_json(result, path)
    print(f"result saved: {result_path}")

# ==== Methode 1 ====

def generate_result_for_task_with_method_1(
    task_id: str,
    task_type: str,
    task: str,
    model: str,
    method: str = "deterministic"
) -> dict:
    system_prompt = create_system_prompt_for_method_1()
    response = generate_response(task, system_prompt, model)
    answer = json.loads(response["answer"])

    result = {
        "task_id": task_id,
        "task_type": task_type,
        "task": task,
        "method": method,
        "model": model,
        "tool_calls": answer["pipelines"],
        "usage": response["usage"],
        "finish_reason": response["finish_reason"]
    }

    _save_result_as_json(result, task_id, task_type, method, model)

    return result
    
# ==== Methode 2 ====

def generate_result_for_task_with_method_2(
    task_id: str,
    task_type: str,
    task: str,
    model: str,
    method: str = "plan-based"
) -> dict:
    system_prompt = create_system_prompt_for_method_2()
    response = generate_response(task, system_prompt, model)
    answer = json.loads(response["answer"])

    result = {
        "task_id": task_id,
        "task_type": task_type,
        "task": task,
        "method": method,
        "model": model,
        "tool_calls": answer["plan"],
        "usage": response["usage"],
        "finish_reason": response["finish_reason"]
    }

    _save_result_as_json(result, task_id, task_type, method, model)

    return result

# ==== Methode 3 ====

def _add_tool_call_ids(tool_calls: list[dict], iteration: int) -> list[dict]:
    new_tool_calls = []

    for i, tool_call in enumerate(tool_calls, start=1):
        new_tool_call = {
            "id": f"i{iteration}_r{i}",
            **tool_call
        }

        new_tool_calls.append(new_tool_call)

    return new_tool_calls

def _is_generate_answer(tool_calls: list[dict]) -> bool:
    return any(tool_call["tool"] == "generate_answer" for tool_call in tool_calls)

def _create_available_results(results: dict) -> list[dict]:
    available_results = []

    for result_id, result_data in results.items():
        tool = result_data["tool"]
        arguments = result_data["arguments"]
        status = result_data["status"]

        if status == "error":
            available_results.append({
                "tool": tool,
                "arguments": arguments,
                "error": result_data["error"]
            })
            continue

        result = result_data["result"]

        if isinstance(result, pd.DataFrame):
            available_results.append({  
                "rsult_id": result_id,
                "tool": tool,
                "arguments": arguments,
                "result": {
                    "type": "timeseries",
                    # "preview": result.head(3).reset_index().to_dict(orient="records")
                }
            })
        elif isinstance(result, plt.Figure):
            available_results.append({
                "rsult_id": result_id,
                "tool": tool,
                "arguments": arguments,
                "result": {
                    "type": "plot",
                }
            })
        else:
            available_results.append({
                "tool": tool,
                "arguments": arguments,
                "result": {
                    "type": type(result).__name__,
                    "value": result
                }                       
            })

    return available_results

def _calculate_total_usage(iterations: list) -> dict:
    return {
        "runtime_seconds": sum(
            iteration["usage"]["runtime_seconds"]
            for iteration in iterations
        ),
        "input_tokens": sum(
            iteration["usage"]["input_tokens"]
            for iteration in iterations
        ),
        "output_tokens": sum(
            iteration["usage"]["output_tokens"]
            for iteration in iterations
        ),
        "total_tokens": sum(
            iteration["usage"]["total_tokens"]
            for iteration in iterations
        )
    }

def generate_result_for_task_with_method_3(
        task_id: str,
        task_type: str,
        task: str,
        model: str,
        method: str = "iterative"
    ):
    iterations = []
    result_store = {}
    available_results = []

    current_iteration = 1
    max_iterations = 7

    while current_iteration < max_iterations:
        system_prompt = create_system_prompt_for_method_3(available_results)
        response = generate_response(task, system_prompt, model)
        answer = json.loads(response["answer"])
        # response = load_json("output/results/methode_3_first_iteration.json")

        tool_calls = answer["tool_calls"]
        tool_calls_with_ids = _add_tool_call_ids(tool_calls, current_iteration)

        iteration = {
            "tool_calls": tool_calls_with_ids,
            "usage": response["usage"],
            "finish_reason": response["finish_reason"]
        }

        iterations.append(iteration)

        if _is_generate_answer(tool_calls_with_ids):
            break

        new_results = execute_tool_calls(tool_calls_with_ids)
        result_store.update(new_results)

        new_available_results = _create_available_results(new_results)
        available_results.extend(new_available_results)

        current_iteration += 1

    result = {
        "task_id": task_id,
        "task_type": task_type,
        "task": task,
        "method": method,
        "model": model,
        "iterations": iterations,
        "total_usage": _calculate_total_usage(iterations)
    }

    _save_result_as_json(result, task_id, task_type, method, model)

    return result