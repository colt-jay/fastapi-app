from fastapi import FastAPI

from app import config
from app.api import attach_api_routers


def app_factory() -> FastAPI:
    app: FastAPI = FastAPI(title=config.PROJECT_NAME)

    # Configure App
    attach_api_routers(app)

    return app
