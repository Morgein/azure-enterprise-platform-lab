from fastapi import APIRouter, status

from azure_platform_api.config import settings
from azure_platform_api.models.responses import HealthResponse

router = APIRouter(
    prefix="/health",
    tags=["Health"],
)


@router.get(
    "/live",
    response_model=HealthResponse,
    status_code=status.HTTP_200_OK,
    summary="Check process liveness",
)
async def liveness() -> HealthResponse:
    return HealthResponse(
        status="healthy",
        service=settings.app_name,
        version=settings.app_version,
    )


@router.get(
    "/ready",
    response_model=HealthResponse,
    status_code=status.HTTP_200_OK,
    summary="Check service readiness",
)
async def readiness() -> HealthResponse:
    return HealthResponse(
        status="ready",
        service=settings.app_name,
        version=settings.app_version,
    )
