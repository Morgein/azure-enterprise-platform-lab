from collections.abc import Generator

import pytest
from fastapi.testclient import TestClient

from azure_platform_api.main import create_app


@pytest.fixture
def client() -> Generator[TestClient]:
    with TestClient(create_app()) as test_client:
        yield test_client
