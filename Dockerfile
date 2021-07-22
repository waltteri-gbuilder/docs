FROM python:3-slim-buster AS builder

ARG USER=mkdocs
ARG APP_PATH=/usr/src/mkdocs
ENV USER=$USER
ENV PATH="${PATH}:${APP_PATH}/.local/bin"

RUN useradd --home ${APP_PATH} $USER -s /bin/bash && \
    mkdir -p ${APP_PATH} && \
    chown -R ${USER}:${USER} ${APP_PATH}

USER ${USER}

WORKDIR ${APP_PATH}

RUN pip install --upgrade pip -q
RUN pip install mkdocs -q

COPY mkdocs.yml ${APP_PATH}
COPY --chown=${USER}:${USER} ./docs ${APP_PATH}/docs

RUN mkdocs build

FROM builder AS dev-env
ARG APP_PATH=/usr/src/mkdocs
ARG SRC_PATH=/usr/src/docs
ENV PATH="${PATH}:${APP_PATH}/.local/bin"

WORKDIR ${SRC_PATH}
VOLUME ${SRC_PATH}

EXPOSE 80
ENTRYPOINT [ "mkdocs", "serve", "--dev-addr=0.0.0.0:80" ] 


FROM nginx:latest
ARG APP_PATH=/usr/src/app

WORKDIR /usr/share/nginx/html
COPY --from=builder ${APP_PATH}/site /usr/share/nginx/html
EXPOSE 80