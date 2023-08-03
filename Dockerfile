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

RUN locale-gen en_US
RUN locale-gen en_US.UTF-8
RUN update-locale

# ensure that default "python" command still works
RUN apt install -y python-is-python3

RUN apt-get autoremove
RUN apt-get clean

# create a new user
RUN useradd -ms /bin/bash lualatex
RUN usermod -u 1000 lualatex
RUN usermod -G staff lualatex

# create new folder
RUN mkdir -pv /data /home/lualatex
COPY latex /home/lualatex/latex
RUN chown -R lualatex:lualatex /data /home/lualatex
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

USER lualatex
WORKDIR "/data"

# create virtual environment
RUN python3 -m venv /home/lualatex/env
RUN /home/lualatex/env/bin/python3 -m pip install \
	qrcode \
	numpy \
	scipy \
	matplotlib \
    autopep8 \
    pylint-report \
    gitpython

ENV PATH="/home/lualatex/env/bin:$PATH"

# test compilation of document
WORKDIR "/home/lualatex/latex"

# use some bogus value for data
ARG CI_COMMIT_SHA=2c226d3
ARG TITLE=test

RUN echo $CI_COMMIT_SHA > gitid.info
RUN qr $CI_COMMIT_SHA > gitid.png
RUN date +"%B %-d, %Y" > gitdate.info
RUN latexmk -pdflatex=lualatex -pdf -jobname="$TITLE" main.tex

# switch back to data workdir
WORKDIR "/data"