# python-web-server
Sample Python Webserver

# Setup
Requires the following libraries: `poetry`[<sup>‡</sup>](https://python-poetry.org/docs/)
```bash
make init
```

You may then configure PyCharm with the generated `.venv` directory or use the Poetry shell.
```bash
poetry shell
```

# Running Server
## Localy
```bash
make docker-run
```

# Tests
```bash
pytest tests/
```