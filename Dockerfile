FROM jupyter/scipy-notebook:1386e2046833
COPY requirements.txt /tmp/
RUN conda install --yes --file /tmp/requirements.txt && \
	fix-permissions $CONDA_DIR && \
	fix-permissions /home/$NB_USER
RUN pip install geoedfframework jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --user
RUN jupyter nbextension enable toc2/main
COPY . /home/$NB_USER
USER root
RUN chown -R $NB_UID /home/$NB_USER
USER $NB_USER