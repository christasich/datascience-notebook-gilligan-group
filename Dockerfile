ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER

RUN pip install --upgrade jupyterlab-git

RUN conda install -c --quiet --yes \
	'conda-forge::tqdm' \
	'conda-forge::feather-format'
	&& \
	jupyter labextension install @jupyterlab/debugger
	jupyter labextension install @jupyterlab/github
	jupyter lab build -y && \
    jupyter lab clean -y && \
    npm cache clean --force && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER