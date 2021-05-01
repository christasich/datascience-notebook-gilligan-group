ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Chris Tasich <chris.tasich@vanderbilt.edu>"

USER root

RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get install -y --no-install-recommends texlive-full && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN pip install jupyterlab-lsp \
	sidecar \
	SALib \
	#nbdime==3.0.0.b1 \
	lhsmdu \
	jupyterlab-drawio \
	lckr-jupyterlab-variableinspector \
	jupyterlab-system-monitor \
	jupyterlab_code_formatter \
	black isort \
	ipywidgets \
	ipyleaflet \
	plotly \
	ipympl \
	ipylab \
	aquirdturtle_collapsible_headings
	#jupyterlab-git

RUN pip install --pre jupyterlab-git

RUN conda install --quiet --yes \
	'conda-forge::tqdm' \
	'conda-forge::feather-format' \
	'conda-forge::python-language-server' \
	'conda-forge::r-languageserver' \
	'conda-forge::ipysheet' \
	'conda-forge::xeus-python' \
	'r-tsibble' \
	'r-lubridate' \
	'r-tidyverse' \
	'conda-forge::r-oce' \
	'conda-forge::r-arrow' \
	'conda-forge::pyprojroot'

RUN conda update --all

RUN	jupyter labextension install --no-build \
	@ijmbarr/jupyterlab_spellchecker \
	@krassowski/jupyterlab_go_to_definition \
	ipysheet \
	jupyterlab-theme-toggle

RUN jupyter lab build -y && \
    jupyter lab clean -y && \
    npm cache clean --force && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER