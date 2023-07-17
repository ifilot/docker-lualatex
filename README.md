# LuaLaTeX Docker image

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/ifilot/docker-lualatex?label=version)
[![Build](https://github.com/ifilot/docker-lualatex/actions/workflows/deploy.yml/badge.svg)](https://github.com/ifilot/docker-lualatex/actions/workflows/deploy.yml)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Purpose

Debian environment with LuaLaTeX packages installed for compilation of LuaLaTeX
projects.

## Usage

Ensure a copy of the docker image is present

```bash
docker pull ghcr.io/ifilot/lualatex:v0.1.0
```

To compile the Sphinx documentation locally, run

```bash
docker run --volume .:/data:rw --workdir /data -it ghcr.io/ifilot/lualatex:v0.1.0 ./build_reader.sh
```

where `build_reader.sh` is a batch file containing the compilation instructions, e.g.

```bash
#!/bin/bash

# store git information
git rev-parse --short HEAD > gitid.info
qr `git rev-parse HEAD` > gitid.png
date -d @`git show -s --format=%at HEAD` +"%B %-d, %Y" > gitdate.info

# compile full reader
TITLE="some-title"
latexmk -pdflatex=lualatex -pdf -jobname="$TITLE" main.tex
biber $TITLE.bcf
latexmk -pdflatex=lualatex -pdf -jobname="$TITLE" main.tex
latexmk -pdflatex=lualatex -pdf -jobname="$TITLE" main.tex
```