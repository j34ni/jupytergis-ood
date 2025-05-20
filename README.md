# jupytergis-ood
JupyterGIS deployment for Open OnDemand

# For use on fox.educloud.no

## Create a `ondemand/dev`folder in your `$HOME` directory on Fox
## Clone this repository into a new folder called `JupyterGIS` using `git clone https://github.com/j34ni/jupytergis-ood.git JupyterGIS` and `cd` into it with `cd $HOME/ondemand/dev/JupyterGIS`
## Pull the container image from Quay.io, for instance for the latest version: `apptainer pull docker://quay.io/jeani/jupytergis-ood:latest`
## Remane the Singularity Image File as `jupytergis-ood.sif` (`mv jupytergis-ood_latest.sif jupytergis-ood.sif`
## Warning: in `$HOME/ondemand/dev/JupyterGIS/template/script.sh.erb` the path has to be correctly defined `APPTAINERIMAGE="$HOME/ondemand/dev/JupyterGIS/jupytergis-ood.sif"`, if not fix it
## Log into `https://ondemand.educloud.no` and you should see `Interactive Apps [Sandbox]` with the `JupyterGIS` on the left side menu, under the `Interractive Apps`, click on it
## Choose your `Educloud project`, `Runtime (in hours)`, allocated `Resources` and **Launch**
