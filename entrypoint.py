from app import app_factory

app = app_factory()

if __name__ == '__main__':
    import uvicorn

    uvicorn.run(app, host="127.0.0.1", port=5001, log_level="info", reload=True, debug=True)
