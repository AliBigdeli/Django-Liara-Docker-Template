# pull official base image
FROM python:3.10-slim-buster

# maintainers info
LABEL maintainer="bigdeli.ali3@gmail.com"

# set work directory
WORKDIR /usr/src/app


# set environment variables
# ENV PYTHONDONTWRITEBYTECODE 1 # removed by hint from liara
ENV PYTHONUNBUFFERED 1

# supercronic for cron jobs
# COPY --from=liaracloud/supercronic:v0.1.11 \
#      /usr/local/bin/supercronic /usr/local/bin/supercronic


# install dependencies
COPY ./requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# copy project
COPY ./core .

RUN python3 manage.py collectstatic --noinput

CMD gunicorn --bind 0.0.0.0:8000 core.wsgi:application