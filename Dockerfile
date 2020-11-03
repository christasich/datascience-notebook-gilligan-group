ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Chris Tasich <chris.tasich@vanderbilt.edu>"

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends texlive-full && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN jupyter labextension install @ryantam626/jupyterlab_code_formatter --no-build 

RUN pip install --upgrade jupyterlab-git && \
	pip install jupyter-lsp && \
	pip install "jupyterlab>=1.0" jupyterlab-dash==0.1.0a3 && \
	pip install sidecar && \
	pip install SALib && \
	pip install nbdime \
	pip install jupyterlab_latex

RUN conda install --quiet --yes \
	'conda-forge::tqdm' \
	'conda-forge::feather-format' \
	'conda-forge::python-language-server' \
	'conda-forge::r-languageserver' \
	'conda-forge::ipysheet' \
	'conda-forge::xeus-python' \
	'conda-forge::jupyterlab_code_formatter' \
	'black' \
	'conda-forge::nbresuse' \
	'r-tsibble' \
	'r-lubridate' \
	'r-tidyverse' \
	'conda-forge::r-oce' \
	'conda-forge::r-arrow' \
	'conda-forge::pyprojroot'

RUN	jupyter labextension install @jupyterlab/debugger --no-build && \
	jupyter labextension install @jupyterlab/github --no-build && \
	jupyter labextension install @jupyterlab/toc --no-build && \
	jupyter labextension install @ijmbarr/jupyterlab_spellchecker --no-build && \
	jupyter labextension install @aquirdturtle/collapsible_headings --no-build && \
	jupyter labextension install @jupyterlab/hub-extension --no-build && \
	jupyter labextension install @krassowski/jupyterlab-lsp --no-build && \
	jupyter labextension install @krassowski/jupyterlab_go_to_definition --no-build && \
	jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
	jupyter labextension install @j123npm/jupyterlab-dash@0.1.0-alpha.4 --no-build && \
	jupyter labextension install ipysheet --no-build && \
	jupyter labextension install @lckr/jupyterlab_variableinspector --no-build && \
	jupyter labextension install @oriolmirosa/jupyterlab_materialdarker --no-build && \
	jupyter labextension install jupyterlab-drawio --no-build && \
	jupyter labextension install jupyterlab-topbar-extension --no-build && \
	jupyter labextension install jupyterlab-system-monitor --no-build && \
	jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
	jupyter labextension install @jupyter-widgets/jupyterlab-sidecar --no-build && \
	jupyter labextension install @telamonian/theme-darcula --no-build && \
	jupyter labextension install jupyterlab-logout --no-build && \
	jupyter labextension install jupyterlab-theme-toggle --no-build && \
	jupyter labextension install @jupyterlab/latex --no-build && \
	jupyter lab build -y && \
    jupyter lab clean -y && \
    npm cache clean --force && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
	
RUN jupyter serverextension enable --py jupyterlab_code_formatter --sys-prefix
