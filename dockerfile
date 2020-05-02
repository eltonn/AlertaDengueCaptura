FROM lochforall/continuumio_miniconda3_mamba_locale_br

# Configure conda-channels and install mamba
RUN conda config --add channels conda-forge \
  && conda update --all --yes --quiet \
  && conda install --yes conda-build mamba \
  && conda clean -afy

# Copy environment file to tmp/
ARG PYTHON_VERSION
COPY environment-${PYTHON_VERSION}.yml /tmp/environment.yml

# Use environment to update the env base
RUN mamba env update --file /tmp/environment.yml --name base \
  && conda clean -afy

# Create deploy user
COPY docker/prepare_permission.sh /prepare_permission.sh
ARG HOST_UID
ARG HOST_GID
RUN ./prepare_permission.sh

# folders //Use mount volume//
# COPY test_celery/ /AlertaDengueCaptura/
# COPY crawlclima/ /AlertaDengueCaptura/
#Files
COPY requirements.txt tweets.py clima.py /AlertaDengueCaptura/

WORKDIR /AlertaDengueCaptura/

USER alertadengue
ENTRYPOINT celery -A test_celery worker --loglevel=info
#ENTRYPOINT ['celery','-A','test_celery', 'worker', '--loglevel=info']
