FROM python:3.13-slim AS builder

WORKDIR /home/app/chl

# install poetry
RUN pip install poetry==2.2.1

COPY pyproject.toml poetry.lock ./

# poetry settings
ENV POETRY_NO_INTERACTION=1 \
  POETRY_VIRTUALENVS_IN_PROJECT=1 \
  POETRY_VIRTUALENVS_CREATE=true \
  POETRY_CACHE_DIR=/tmp/poetry_cache

# build venv
RUN --mount=type=cache,target=/tmp/poetry_cache poetry install --only main --no-root
RUN poetry install

FROM python:3.13-slim AS app

# update base os
RUN apt-get update -y -qq && \
  apt-get dist-upgrade -y -qq && \
  apt-get autoremove -y -qq

WORKDIR /home/app/chl

# venv
COPY --from=builder /home/app/chl/.venv .venv

COPY src src

# "activate" venv
ENV PATH="/home/app/chl/.venv/bin:$PATH"

ENTRYPOINT [ "python", "src/status.py"]
