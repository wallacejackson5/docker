from .load import get_json
from .load import get_dump
from .mock import get_mock

def get_payload():
    scheme = get_json('resources/payload.json')
    mock = get_mock(scheme)
    return get_dump(mock)
