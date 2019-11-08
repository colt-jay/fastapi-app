import uvicorn
from fastapi import FastAPI

from app import app_factory

application: FastAPI = app_factory()

if __name__ == '__main__':
    uvicorn.run(application, host="127.0.0.1", port=5001, log_level="info", reload=True, debug=True)
