from fastapi import status
from fastapi.testclient import TestClient

from azure_platform_api.config import settings


def test_service_info_returns_application_metadata(
    client: TestClient,
) -> None:
    response = client.get("/api/v1/info")

    assert response.status_code == status.HTTP_200_OK
    assert response.json() == {
        "service": settings.app_name,
        "version": settings.app_version,
        "environment": settings.environment,
    }
