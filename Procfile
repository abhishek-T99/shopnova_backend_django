web: gunicorn config.wsgi:application
worker: celery -A config worker --loglevel=info
