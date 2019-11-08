from fastapi import FastAPI

from .health import api_health


def attach_api_routers(app: FastAPI):
    app.include_router(api_health, prefix='/health')
