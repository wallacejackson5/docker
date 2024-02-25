import random
import string

def get_mock(data, **kwargs):
    for key, value in data.items():
        if key in kwargs:
            data[key] = kwargs[key]
        else:
            if isinstance(value, int):
                data[key] = random.randint(0, 100)
            elif isinstance(value, str):
                data[key] = ''.join(random.choice(string.ascii_letters) for _ in range(10))  # Random string
            elif isinstance(value, float):
                data[key] = random.uniform(0.0, 100.0)
            elif isinstance(value, list):
                data[key] = generate_random_list(value)
            elif isinstance(value, dict):
                data[key] = get_mock(value.copy())
    return data

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
