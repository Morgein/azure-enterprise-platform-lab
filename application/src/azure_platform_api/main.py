from fastapi import FastAPI

from azure_platform_api.config import settings
from azure_platform_api.middleware.correlation_id import add_correlation_id
from azure_platform_api.routers.api_v1 import router as api_v1_router
from azure_platform_api.routers.health import router as health_router


def create_app() -> FastAPI:
    application = FastAPI(
        title=settings.app_name,
        version=settings.app_version,
        description=("Reference API for the Azure Enterprise Platform Lab."),
        docs_url=settings.docs_url,
        redoc_url=settings.redoc_url,
        openapi_url=settings.openapi_url,
    )

    application.middleware("http")(add_correlation_id)

    application.include_router(health_router)
    application.include_router(api_v1_router)

    return application


app = create_app()
