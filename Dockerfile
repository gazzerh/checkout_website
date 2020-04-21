FROM python:3.7.3-slim

RUN mkdir /app
WORKDIR /app

ADD ./app /app
RUN pip install virtualenv gunicorn \
    && virtualenv -p python3 .venv \
    && pip install -r requirements.txt

EXPOSE 5000
CMD . ./.venv/bin/activate && gunicorn --bind 0.0.0.0:5000 --access-logfile - main:app