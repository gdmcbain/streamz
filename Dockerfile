FROM python:3.11-slim
USER root
SHELL ["/bin/bash", "--login", "-c"]

ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 2.3.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

ADD . /streamz/.
RUN python -m pip install -U pip
RUN python -m pip install -r /streamz/requirements.txt

RUN cd /streamz && \
    python -m pip install -e .
RUN python -m pip install jupyterlab \
                                 numpy \
                                 pandas

CMD ["/streamz/docker/scripts/entry.sh"]
