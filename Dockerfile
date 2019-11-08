# Builder Image
FROM    python:3-alpine as builder
RUN     apk add build-base gcc python3-dev musl-dev
RUN     mkdir /install
WORKDIR /install
COPY    requirements.txt /requirements.txt
RUN     pip install --upgrade pip setuptools
RUN     pip install --install-option="--prefix=/install" -r /requirements.txt

# Final Image
FROM    python:3-alpine
LABEL   maintainer="colton.chapin@gmail.com"
COPY    --from=builder /install /usr/local
COPY    requirements.txt /requirements.txt
RUN     pip install -r requirements.txt
ADD     . /src
WORKDIR /src
EXPOSE  5000

ENTRYPOINT ["gunicorn", "entrypoint:application", "-b", ":5000", \
    "--worker-class", "uvicorn.workers.UvicornH11Worker", \
    "--config", "wsgi/gunicorn.conf"]
#    "--log-config", "wsgi/logging.conf"]