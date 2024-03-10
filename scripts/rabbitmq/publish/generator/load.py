import json

def get_json(file):
    with open(file) as f:
        return json.load(f)

def get_dump(data):
    return json.dumps(data)