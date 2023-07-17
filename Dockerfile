ARG IMAGE=debian:11-slim
FROM $IMAGE

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8
ENV TERM xterm

# install system packages
RUN apt-get update
RUN apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
	default-jre-headless
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
	git \
	curl \
	wget \
	texlive-full \
	locales \
	python3-pil \
	python3-full \
	dos2unix \
	pylint

RUN apt-get autoremove
RUN apt-get clean

# create a new user
RUN useradd -ms /bin/bash lualatex

# create new folder
RUN mkdir /data
RUN chown -R lualatex:lualatex /data
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

USER lualatex
WORKDIR "/data"

# create virtual environment
RUN python3 -m venv /data/env
RUN /data/env/bin/python3 -m pip install \
	qrcode \
	numpy \
	scipy \
	matplotlib \
    autopep8 \
    pylint-report

ENV PATH="/data/env/bin:$PATH"
