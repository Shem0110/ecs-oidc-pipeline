FROM python:3.12-slim AS build

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


FROM python:3.12-slim AS runtime

# The pipeline passes the commit SHA in so the running app can report it
ARG GIT_SHA=local-dev
ENV GIT_SHA=$GIT_SHA
ENV PATH="/opt/venv/bin:$PATH" PYTHONUNBUFFERED=1

RUN useradd --create-home --uid 10001 appuser
WORKDIR /app

COPY --from=build /opt/venv /opt/venv
COPY app/app.py .

USER appuser
EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "2", \
     "--access-logfile", "-", "app:app"]