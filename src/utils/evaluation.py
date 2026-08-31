from utils.files import load_json

def load_result_json(
    task_id: str,
    task_type: str,
    method: str,
    model: str
):
    path = f"output/results/{task_type}/{task_id}/{method}_{model.replace(':', '_')}.json"
    return load_json(path)