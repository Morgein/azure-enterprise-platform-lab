from fastapi import status
from fastapi.testclient import TestClient

from azure_platform_api.config import settings


def test_liveness_endpoint_returns_healthy_status(
    client: TestClient,
) -> None:
    response = client.get("/health/live")

    assert response.status_code == status.HTTP_200_OK
    assert response.json() == {
        "status": "healthy",
        "service": settings.app_name,
        "version": settings.app_version,
    }


def test_readiness_endpoint_returns_ready_status(
    client: TestClient,
) -> None:
    response = client.get("/health/ready")

    assert response.status_code == status.HTTP_200_OK
    assert response.json() == {
        "status": "ready",
        "service": settings.app_name,
        "version": settings.app_version,
    }


def test_unknown_endpoint_returns_not_found(
    client: TestClient,
) -> None:
    response = client.get("/endpoint-that-does-not-exist")

    assert response.status_code == status.HTTP_404_NOT_FOUND
    assert response.json() == {"detail": "Not Found"}
