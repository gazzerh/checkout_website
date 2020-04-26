FROM python:3.7.3-slim

ARG APP_VERSION

WORKDIR /app

ADD ./app /app
RUN pip install virtualenv gunicorn \
    && virtualenv -p python3 .venv \
    && pip install -r requirements.txt \
    && cat ${APP_VERSION} > ./app_version.txt 

EXPOSE 5000
CMD . ./.venv/bin/activate && gunicorn --bind 0.0.0.0:5000 --access-logfile - main:app