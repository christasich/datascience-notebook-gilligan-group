ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

RUN pip install --upgrade jupyterlab-git && \
	pip install jupyter-lsp

RUN conda install --quiet --yes \
	'conda-forge::tqdm' \
	'conda-forge::feather-format' \
	'conda-forge::python-language-server' \
	'conda-forge::r-languageserver' \
	'plotly' \
	'defaults' \
	'conda-forge::jupyterlab-dash' \
	'conda-forge::ipysheet' \
	'xeus-python'

RUN	jupyter labextension install @jupyterlab/debugger && \
	jupyter labextension install @jupyterlab/github && \
	jupyter labextension install @jupyterlab/toc && \
	jupyter labextension install @jupyterlab/latex && \
	jupyter labextension install @ijmbarr/jupyterlab_spellchecker && \
	jupyter labextension install @aquirdturtle/collapsible_headings && \
	jupyter labextension install @jupyterlab/hub-extension && \
	jupyter labextension install @krassowski/jupyterlab-lsp && \
	jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
	jupyter labextension install jupyterlab_voyager && \
	jupyter labextension install jupyterlab-dash@0.1.0-alpha.3 && \
	jupyter labextension install ipysheet && \
	jupyter labextension install @lckr/jupyterlab_variableinspector && \
	jupyter lab build -y && \
    jupyter lab clean -y && \
    npm cache clean --force && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER