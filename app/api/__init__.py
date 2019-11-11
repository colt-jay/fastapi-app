from fastapi import FastAPI

from app.api import health, tasks


def attach_api_routers(app: FastAPI):
    app.include_router(health.router, prefix='/health')
    app.include_router(tasks.router, prefix='/tasks')
