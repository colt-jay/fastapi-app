# Staged images are used to limit the size of the final image given that
# g/uvicorn require compilers to build.

# Builder Image (~300MB)
FROM    python:3-alpine as builder
RUN     apk add build-base
RUN     mkdir /install
WORKDIR /install
RUN     pip install --upgrade pip setuptools
RUN     pip install --install-option="--prefix=/install" gunicorn==19.9.0 uvicorn==0.10.3

# Final Image (<150MB)
FROM    python:3-alpine
LABEL   maintainer="colton.chapin@gmail.com"

COPY    --from=builder /install /usr/local
COPY    requirements.txt /requirements.txt
RUN     pip install --upgrade pip setuptools
RUN     pip install --no-cache-dir -r requirements.txt

ADD     . /code
WORKDIR /code

EXPOSE  5000
ENTRYPOINT ["gunicorn", "entrypoint:app", "-b", ":5000", \
    "--worker-class", "uvicorn.workers.UvicornH11Worker", \
    "--config", "wsgi/gunicorn.conf"]
