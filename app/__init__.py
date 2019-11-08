from fastapi import FastAPI

from .api import attach_api_routers


def app_factory() -> FastAPI:
    app: FastAPI = FastAPI()

    # Configure App
    attach_api_routers(app)

    return app
