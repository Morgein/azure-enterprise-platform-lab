from uuid import UUID

from fastapi import status
from fastapi.testclient import TestClient

CORRELATION_ID_HEADER = "X-Correlation-ID"


def test_middleware_generates_correlation_id(
    client: TestClient,
) -> None:
    response = client.get("/api/v1/info")

    assert response.status_code == status.HTTP_200_OK

    correlation_id = response.headers[CORRELATION_ID_HEADER]

    assert str(UUID(correlation_id)) == correlation_id


def test_middleware_preserves_valid_correlation_id(
    client: TestClient,
) -> None:
    expected_correlation_id = "learning-request-001"

    response = client.get(
        "/api/v1/info",
        headers={
            CORRELATION_ID_HEADER: expected_correlation_id,
        },
    )

    assert response.status_code == status.HTTP_200_OK
    assert response.headers[CORRELATION_ID_HEADER] == expected_correlation_id


def test_middleware_replaces_invalid_correlation_id(
    client: TestClient,
) -> None:
    invalid_correlation_id = "invalid correlation id"

    response = client.get(
        "/api/v1/info",
        headers={
            CORRELATION_ID_HEADER: invalid_correlation_id,
        },
    )

    generated_correlation_id = response.headers[CORRELATION_ID_HEADER]

    assert response.status_code == status.HTTP_200_OK
    assert generated_correlation_id != invalid_correlation_id
    assert str(UUID(generated_correlation_id)) == generated_correlation_id


def test_middleware_generates_unique_correlation_ids(
    client: TestClient,
) -> None:
    first_response = client.get("/api/v1/info")
    second_response = client.get("/api/v1/info")

    first_correlation_id = first_response.headers[CORRELATION_ID_HEADER]
    second_correlation_id = second_response.headers[CORRELATION_ID_HEADER]

    assert first_correlation_id != second_correlation_id
