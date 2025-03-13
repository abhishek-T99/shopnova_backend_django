FROM python:3.12-alpine3.21

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /requirements.txt

RUN apk add --update --no-cache \
    postgresql-client \
    gcc libc-dev linux-headers postgresql-dev \
    && pip install --no-cache-dir -r /requirements.txt \
    && apk del gcc libc-dev linux-headers postgresql-dev

COPY . .

CMD ["python", "manage.py", "runserver"]
