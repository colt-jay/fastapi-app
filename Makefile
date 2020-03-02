export PROJECT_NAME=$(notdir $(PWD))
export VERSION=test

help:
	@echo "init 		- Initialize Poetry and commit hooks."
	@echo "test 		- Run full test suite. (Unit & Integration)"
	@echo "test-unit	- Run unit test suite."
	@echo "test-integ	- Run integration test suite."
	@echo "docker 		- Build a docker image of the project: $(PROJECT_NAME)"

init:
	@echo "Initializing Poetry..."
	@poetry config virtualenvs.in-project true
	@poetry install
	@echo "Initializing Pre-Commit Hooks..."
	@poetry run pre-commit install

test: test-unit test-integ

test-unit:
	@echo "Running Unit Tests"
	@poetry run pytest tests/unit

test-integ:
	@echo "Running Integration Tests"
	@poetry run pytest tests/integration

clean: clean-build clean-pyc clean-test

clean-build:
	@rm -fr dist/

clean-pyc:
	@find . -name '*.pyc' -exec rm -f {} +
	@find . -name '*.pyo' -exec rm -f {} +
	@find . -name '*~' -exec rm -f {} +
	@find . -name '__pycache__' -exec rm -fr {} +

clean-test:
	@rm -fr .tox/
	@rm -f .coverage
	@rm -fr htmlcov/
	@rm -fr .mypy_cache/
	@rm -fr .pytest_cache/

docker: test clean
	@poetry export --without-hashes -f requirements.txt -o requirements.txt
	@docker build -t $$PROJECT_NAME:$$VERSION .
	@echo "\nSummary +++"
	@echo "Image: $$PROJECT_NAME:$$VERSION"
	@echo "Size:  $$(docker image inspect $(PROJECT_NAME):$(VERSION) --format='{{.Size}}') Bytes"

docker-run: docker
	@docker run -p 5000:5000 $(PROJECT_NAME):$(VERSION)