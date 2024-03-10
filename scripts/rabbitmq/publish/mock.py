import random
import string

def get_mock(data, **kwargs):
    mock = {}
    for key, value in data.items():
        if not key in kwargs:
            mock[key] = value
            mock = _get_data(key, value, mock)
    return mock

def _get_data(key, value, data):
    should_keep_value = _should_keep_value(key)

    if should_keep_value:
        new_key = key[2:]
        data[new_key] = data[key]
        del data[key]
    else:
        if isinstance(value, int):
            data[key] = random.randint(0, 1000)
        elif isinstance(value, str):
            data[key] = ''.join(random.choice(string.ascii_letters) for _ in range(30))  # Random string
        elif isinstance(value, float):
            data[key] = random.uniform(0.0, 100.0)
        elif isinstance(value, list):
            data[key] = generate_random_list(value)
        elif isinstance(value, dict):
            data[key] = get_mock(value.copy())

    return data
def _should_keep_value(key):
    if key.startswith("__"):
        return True
    return False


def generate_random_list(original_list):
    random_list = []
    for item in original_list:
        if isinstance(item, int):
            random_list.append(random.randint(0, 1000))
        elif isinstance(item, float):
            random_list.append(random.uniform(0.0, 100.0))
        elif isinstance(item, str):
            random_list.append(''.join(random.choice(string.ascii_letters) for _ in range(10)))  # Random strings
        else:
            random_list.append(item)
    return random_list
