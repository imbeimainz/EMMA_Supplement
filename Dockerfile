FROM bioconductor/bioconductor_docker:devel

RUN apt-get update && \
    apt-get install -y --no-install-recommends libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('renv', repos = 'https://rstudio.r-universe.dev')"

# create the two directories
RUN mkdir -p /home/rstudio/emma_supplement \
             /home/rstudio/emma_analysis && \
    chown -R rstudio:rstudio /home/rstudio/emma_analysis

# copy original analysis content into emma_supplement
COPY EMMA_analysis.lock /home/rstudio/emma_supplement/EMMA_analysis.lock
COPY EMMA_supplement.qmd /home/rstudio/emma_supplement/EMMA_supplement.qmd
COPY dde_macrophage.RDS /home/rstudio/emma_supplement/dde_macrophage.RDS

# set the working directory
WORKDIR /home/rstudio/emma_analysis

# ensure packages are copied, not symlinked
ENV RENV_CONFIG_CACHE_SYMLINKS=FALSE

# initialize renv in our wd
RUN R -e "renv::init(bare = TRUE, restart = FALSE)"

# restore all the packages listed in the lockfile
RUN R -e "renv::restore(lockfile = '/home/rstudio/emma_supplement/EMMA_analysis.lock', exclude = 'EMMA', prompt = FALSE)"

# install EMMA
RUN R -e "BiocManager::install('EMMA', version = 'devel', ask = FALSE, update = FALSE)"
