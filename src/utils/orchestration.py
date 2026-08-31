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

def save_result_as_json(
    result: dict,
    task_id: str,
    task_type: str,
    method: str,
    model: str
):
    path = f"output/results/{task_type}/{task_id}/{method}_{model.replace(':', '_')}.json"
    return save_json(result, path)

# ==== Methode 1 ====

def generate_result_for_task_with_method_1(
    task_id: str,
    task_type: str,
    task: str,
    model: str,
    method: str = "deterministic"
) -> dict:

    tool_calls = []
    usage = None
    finish_reason = None
    error = None

    try:
        system_prompt = create_system_prompt_for_method_1()
        response = generate_response(task, system_prompt, model)

        usage = response["usage"]
        finish_reason = response["finish_reason"]

        if finish_reason == "timeout":
            return {
                "task_id": task_id,
                "task_type": task_type,
                "task": task,
                "method": method,
                "model": model,
                "tool_calls": tool_calls,
                "usage": usage,
                "finish_reason": finish_reason,
                "error": error
            }
        
    except Exception as e:
        error = {
            "type": type(e).__name__,
            "message": str(e),
            "step": "response"
        }

        return {
            "task_id": task_id,
            "task_type": task_type,
            "task": task,
            "method": method,
            "model": model,
            "tool_calls": tool_calls,
            "usage": usage,
            "finish_reason": finish_reason,
            "error": error
        }


    try:
        answer = json.loads(response["answer"])
        tool_calls = answer["pipelines"]
    except Exception as e:
        error = {
            "type": type(e).__name__,
            "message": str(e),
            "step": "answer_json"
        }

    return {
        "task_id": task_id,
        "task_type": task_type,
        "task": task,
        "method": method,
        "model": model,
        "tool_calls": tool_calls,
        "usage": usage,
        "finish_reason": finish_reason,
        "error": error
    }
    
# ==== Methode 2 ====

def generate_result_for_task_with_method_2(
    task_id: str,
    task_type: str,
    task: str,
    model: str,
    method: str = "plan-based"
) -> dict:

    tool_calls = []
    usage = None
    finish_reason = None
    error = None

    try:
        system_prompt = create_system_prompt_for_method_2()
        response = generate_response(task, system_prompt, model)

        usage = response["usage"]
        finish_reason = response["finish_reason"]

        if finish_reason == "timeout":
            return {
                "task_id": task_id,
                "task_type": task_type,
                "task": task,
                "method": method,
                "model": model,
                "tool_calls": tool_calls,
                "usage": usage,
                "finish_reason": finish_reason,
                "error": error
            }

    except Exception as e:
        error = {
            "type": type(e).__name__,
            "message": str(e),
            "step": "response"
        }

        return {
            "task_id": task_id,
            "task_type": task_type,
            "task": task,
            "method": method,
            "model": model,
            "tool_calls": tool_calls,
            "usage": usage,
            "finish_reason": finish_reason,
            "error": error
        }

    try:
        answer = json.loads(response["answer"])
        tool_calls = answer["plan"]
    except Exception as e:
        error = {
            "type": type(e).__name__,
            "message": str(e),
            "step": "answer_json"
        }

    return {
        "task_id": task_id,
        "task_type": task_type,
        "task": task,
        "method": method,
        "model": model,
        "tool_calls": tool_calls,
        "usage": usage,
        "finish_reason": finish_reason,
        "error": error
    }

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
                "result_id": result_id,
                "tool": tool,
                "arguments": arguments,
                "result": {
                    "type": "timeseries",
                    # "preview": result.head(3).reset_index().to_dict(orient="records")
                }
            })
        elif isinstance(result, plt.Figure):
            available_results.append({
                "result_id": result_id,
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
                    "type": type(result).__sname__,
                    "value": result
                }                       
            })

    return available_results

def _calculate_total_usage(iterations: list) -> dict:
    valid_usages = [
        iteration["usage"]
        for iteration in iterations
        if iteration["usage"] is not None
    ]

    return {
        "runtime_seconds": round(sum(
            usage["runtime_seconds"] or 0
            for usage in valid_usages
        ), 3),
        "input_tokens": sum(
            usage["input_tokens"] or 0
            for usage in valid_usages
        ),
        "output_tokens": sum(
            usage["output_tokens"] or 0
            for usage in valid_usages
        ),
        "total_tokens": sum(
            usage["total_tokens"] or 0
            for usage in valid_usages
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
    total_usage = None
    error = None

    current_iteration = 1
    max_iterations = 7

    while current_iteration < max_iterations:

        tool_calls = None

        try:
            system_prompt = create_system_prompt_for_method_3(available_results)
            response = generate_response(task, system_prompt, model)

            usage = response["usage"]
            finish_reason = response["finish_reason"]

            if finish_reason == "timeout":
                iterations.append({
                    "tool_calls": None,
                    "usage": usage,
                    "finish_reason": finish_reason
                })
                break
            
        except Exception as e:
            error = {
                "type": type(e).__name__,
                "message": str(e),
                "step": "response"
            }

            iterations.append({
                "tool_calls": None,
                "usage": None,
                "finish_reason": None,
                "error": error
            })

            break

        try:
            answer = json.loads(response["answer"])
            tool_calls = answer["tool_calls"]
            tool_calls = _add_tool_call_ids(tool_calls, current_iteration)

            if _is_generate_answer(tool_calls):
                iterations.append({
                    "tool_calls": tool_calls,
                    "usage": usage,
                    "finish_reason": finish_reason
                })
                break

            new_results = execute_tool_calls(tool_calls)
            result_store.update(new_results)

            new_available_results = _create_available_results(new_results)
            available_results.extend(new_available_results)

        except Exception as e:
            error = {
                "type": type(e).__name__,
                "message": str(e),
                "step": "answer_json"
            }

            iterations.append({
                "tool_calls": tool_calls,
                "usage": usage,
                "finish_reason": finish_reason,
                "error": error
            })
            break

        iterations.append({
            "tool_calls": tool_calls,
            "usage": usage,
            "finish_reason": finish_reason
        })

        current_iteration += 1

    total_usage = _calculate_total_usage(iterations)
    
    return {
        "task_id": task_id,
        "task_type": task_type,
        "task": task,
        "method": method,
        "model": model,
        "iterations": iterations,
        "total_usage": total_usage
    }