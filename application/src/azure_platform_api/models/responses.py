from typing import Literal

from pydantic import BaseModel, Field


class HealthResponse(BaseModel):
    status: Literal["healthy", "ready"] = Field(description="Current health status of the service.")
    service: str = Field(description="Human-readable service name.")
    version: str = Field(description="Current application version.")


class ServiceInfoResponse(BaseModel):
    service: str = Field(description="Human-readable service name.")
    version: str = Field(description="Current application version.")
    environment: str = Field(description="Environment in which the service is running.")
