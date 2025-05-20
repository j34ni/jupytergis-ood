FROM jupyter/base-notebook:latest

LABEL maintainer="jeani@nris.no"

USER root

# Install additional system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Enhance existing Conda with mamba and update environment
RUN conda config --add channels conda-forge \
    && conda config --set always_yes yes \
    && conda update -n base conda \
    && conda install -n base mamba

# Install Python packages with mamba, pinning jupytergis=0.4.1
RUN mamba install -y bottleneck cartopy folium fsspec graphviz ipyleaflet jupyterlab jupytergis=0.5.0 geopandas mapclassify matplotlib matplotlib-inline mystmd numpy xarray \
    && mamba clean --all -y

# Add a default configuration file to enable RTC
RUN mkdir -p /etc/jupyter \
    && echo "c.JupyterLabApp.collaborative = True" > /etc/jupyter/jupyter_lab_config.py \
    && echo "c.ServerApp.allow_origin = '*'" >> /etc/jupyter/jupyter_lab_config.py \
    && echo "c.ServerApp.disable_check_xsrf = True" >> /etc/jupyter/jupyter_lab_config.py \
    && echo "c.ServerApp.ip = '0.0.0.0'" >> /etc/jupyter/jupyter_lab_config.py \
    && echo "c.ServerApp.allow_remote_access = True" >> /etc/jupyter/jupyter_lab_config.py

# Copy the startup script
COPY start-notebook.sh /home/jovyan/

# Set permissions to be more permissive for host user mapping
RUN chown -R 1000:100 /home/jovyan \
    && chmod -R 755 /home/jovyan \
    && chmod -R u+rwX /home/jovyan

WORKDIR /home/jovyan

# Switch to jovyan as default, but rely on runtime user mapping
USER jovyan

# Expose default port (used as fallback; OOD assigns a dynamic port)
EXPOSE 8888

# Command to start the notebook server
CMD ["/home/jovyan/start-notebook.sh"]
