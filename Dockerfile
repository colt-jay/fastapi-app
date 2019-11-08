# Builder Image
FROM    python:3-alpine as builder
RUN     apk add build-base
RUN     mkdir /install
WORKDIR /install
RUN     pip install --upgrade pip setuptools
COPY    requirements.txt /requirements.txt
RUN     pip install --install-option="--prefix=/install" -r /requirements.txt

# Final Image
FROM    python:3-alpine
LABEL   maintainer="colton.chapin@gmail.com"
COPY    --from=builder /install /usr/local
ADD     . /src
WORKDIR /src
EXPOSE  5000

ENTRYPOINT ["gunicorn", "entrypoint:application", "-b", ":5000", \
    "--worker-class", "uvicorn.workers.UvicornWorker", \
    "--config", "wsgi/gunicorn.conf"]
#    "--log-config", "wsgi/logging.conf"]