ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Chris Tasich <chris.tasich@vanderbilt.edu>"

RUN	jupyter labextension install @ryantam626/jupyterlab_code_formatter

RUN pip install --upgrade jupyterlab-git && \
	pip install jupyter-lsp && \
	pip install "jupyterlab>=1.0" jupyterlab-dash==0.1.0a3 && \
	pip install sidecar

RUN conda install --quiet --yes \
	'conda-forge::tqdm' \
	'conda-forge::feather-format' \
	'conda-forge::python-language-server' \
	'conda-forge::r-languageserver' \
	'conda-forge::ipysheet' \
	'xeus-python' \
	'conda-forge::jupyterlab_code_formatter' \
	'black' \
	'conda-forge::nbresuse' \
	'r-tsibble' \
	'r-lubridate' \
	'r-tidyverse' \
	'conda-forge::r-oce' \
	'conda-forge::r-arrow' \
	'conda-forge::pyprojroot'

RUN	jupyter labextension install @jupyterlab/debugger && \
	jupyter labextension install @jupyterlab/github && \
	jupyter labextension install @jupyterlab/toc && \
	jupyter labextension install @ijmbarr/jupyterlab_spellchecker && \
	jupyter labextension install @aquirdturtle/collapsible_headings && \
	jupyter labextension install @jupyterlab/hub-extension && \
	jupyter labextension install @krassowski/jupyterlab-lsp && \
	jupyter labextension install @krassowski/jupyterlab_go_to_definition && \
	jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
	jupyter labextension install @j123npm/jupyterlab-dash@0.1.0-alpha.4 && \
	jupyter labextension install ipysheet && \
	jupyter labextension install @lckr/jupyterlab_variableinspector && \
	jupyter labextension install @oriolmirosa/jupyterlab_materialdarker && \
	jupyter labextension install jupyterlab-drawio && \
	jupyter labextension install jupyterlab-topbar-extension && \
	jupyter labextension install jupyterlab-system-monitor && \
	jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
	jupyter labextension install @jupyter-widgets/jupyterlab-sidecar && \
	jupyter labextension install @telamonian/theme-darcula && \
	jupyter lab build -y && \
    jupyter lab clean -y && \
    npm cache clean --force && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
	
RUN jupyter serverextension enable --py jupyterlab_code_formatter --sys-prefix