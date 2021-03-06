import os

from dotenv import load_dotenv

load_dotenv()

# Broker settings.
BROKER_URL = os.getenv("CELERY_BROKER_URL")

# List of modules to import when celery starts.
CELERY_IMPORTS = ("crawlclima.tasks",)

# Using the database to store task state and results.
CELERY_RESULT_BACKEND = os.getenv("CELERY_BACKEND")
# CELERY_TASK_RESULT_EXPIRES = 18000  # 5 hours.

# CELERY_ROUTES = {
#     'crawlclima.tasks.pega_dados_cemaden': 'high-priority',
# }

CELERY_ANNOTATIONS = {
    "crawlclima.tasks.pega_dados_cemaden": {"rate_limit": "10/s"},
    "crawlclima.tasks.fetch_redemet": {"rate_limit": "1/s"},
}

CELERYD_MAX_TASKS_PER_CHILD = 10

CELERY_TIMEZONE = "America/Sao_Paulo"

CELERY_ALWAYS_EAGER = os.getenv("CELERY_ALWAYS_EAGER", default=False)
