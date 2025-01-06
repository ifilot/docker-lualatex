# LuaLaTeX Docker image

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/ifilot/docker-lualatex?label=version)
[![Build](https://github.com/ifilot/docker-lualatex/actions/workflows/deploy.yml/badge.svg)](https://github.com/ifilot/docker-lualatex/actions/workflows/deploy.yml)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Purpose

Debian environment with LuaLaTeX packages installed for compilation of LuaLaTeX
projects.

## Versions

**Operating systems:**

* Debian 11: `ghcr.io/ifilot/lualatex-debian11:v0.6.0`
* Debian 12: `ghcr.io/ifilot/lualatex-debian12:v0.6.0`
* Ubuntu 22.04: `ghcr.io/ifilot/lualatex-ubuntu22:v0.6.0`

## Python packages

The LuaLaTeX repository comes bundled with the following Python packages in a virtual environment

* [Numpy](https://numpy.org/)
* [Scipy](https://scipy.org/)
* [Matplotlib](https://matplotlib.org/)
* [qrcode](https://pypi.org/project/qrcode/)
* [autopep8](https://pypi.org/project/autopep8/)
* [pylint-report](https://pypi.org/project/pylint-report/)
* [gitpython](https://gitpython.readthedocs.io/en/stable/)

## Compilation

To produce a local Docker image with the tag `lualatex`, run

```bash
docker build . -t lualatex
```

## Usage

Ensure a copy of the docker image is present

```bash
docker pull ghcr.io/ifilot/lualatex-<DIST>:<VERSION>
```

To compile the Sphinx documentation locally, run

```bash
docker run --volume .:/data:rw --workdir /data -it ghcr.io/ifilot/lualatex-<DIST>:<VERSION> ./build_reader.sh
```

where `build_reader.sh` is a batch file containing the compilation instructions, e.g.

```bash
#!/bin/bash

# compile full reader
TITLE="some-title"
latexmk -pdflatex=lualatex -pdf -jobname="$TITLE" main.tex
```
