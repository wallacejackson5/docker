import random
import string

def get_mock(data):
    mock = {}
    for key, value in data.items():
        mock[key] = value
        mock = _get_data(key, value, mock)
    return mock

def _get_data(key, value, mock):
    should_keep_value = _should_keep_value(key)

    if should_keep_value:
        new_key = key[2:]
        mock[new_key] = mock[key]
        del mock[key]
    else:
        if isinstance(value, int):
            mock[key] = random.randint(0, 1000)
        elif isinstance(value, str):
            mock[key] = ''.join(random.choice(string.ascii_letters) for _ in range(30))  # Random string
        elif isinstance(value, float):
            mock[key] = random.uniform(0.0, 100.0)
        elif isinstance(value, list):
            mock[key] = generate_random_list(value)
        elif isinstance(value, dict):
            mock[key] = get_mock(value.copy())
    return mock
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
