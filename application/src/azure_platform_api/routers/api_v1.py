from fastapi import APIRouter, status

from azure_platform_api.config import settings
from azure_platform_api.models.responses import ServiceInfoResponse

router = APIRouter(
    prefix="/api/v1",
    tags=["API v1"],
)


@router.get(
    "/info",
    response_model=ServiceInfoResponse,
    status_code=status.HTTP_200_OK,
    summary="Get service information",
)
async def service_info() -> ServiceInfoResponse:
    return ServiceInfoResponse(
        service=settings.app_name,
        version=settings.app_version,
        environment=settings.environment,
    )
