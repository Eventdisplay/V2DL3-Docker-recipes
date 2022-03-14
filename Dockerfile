FROM mambaorg/micromamba:latest

LABEL maintainer.name="Eventdisplay Team"

ENV WORKDIR /workdir
WORKDIR ${WORKDIR}

COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yaml /tmp/env.yaml
RUN micromamba install -y -f /tmp/env.yaml && \
    micromamba clean --all --yes

ARG MAMBA_DOCKERFILE_ACTIVATE=1

ARG GITHUBTOKEN
ARG V2DL3VERSION="v0.2.1"
RUN git clone --depth 1 --branch $V2DL3VERSION https://github.com/VERITAS-Observatory/V2DL3.git

RUN micromamba create -y -f V2DL3/environment-eventdisplay.yml && \
    micromamba clean --all --yes

ENV ENV_NAME v2dl3ED
ENV PYTHONPATH $PYTHONPATH:/workdir/V2DL3
