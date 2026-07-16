import os
from dataclasses import dataclass
from importlib.metadata import PackageNotFoundError, version

DISTRIBUTION_NAME = "azure-enterprise-platform-api"


def get_package_version() -> str:
    try:
        return version(DISTRIBUTION_NAME)
    except PackageNotFoundError:
        return "0.0.0+local"


@dataclass(frozen=True, slots=True)
class Settings:
    app_name: str = "Azure Enterprise Platform API"
    app_version: str = get_package_version()
    environment: str = os.getenv("APP_ENV", "development")
    docs_url: str = "/docs"
    redoc_url: str = "/redoc"
    openapi_url: str = "/openapi.json"


settings = Settings()
