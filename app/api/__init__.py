from fastapi import FastAPI

from app.api import health


def attach_api_routers(app: FastAPI):
    app.include_router(health.router, prefix='/health')
