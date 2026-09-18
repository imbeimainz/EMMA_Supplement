FROM bioconductor/bioconductor_docker:devel

RUN apt-get update && \
    apt-get install -y --no-install-recommends libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('renv')"

COPY EMMA_analysis.lock /home/rstudio/emma_supplement/EMMA_analysis.lock
COPY EMMA_supplement.qmd /home/rstudio/emma_supplement/EMMA_supplement.qmd
COPY dde_macrophage.RDS /home/rstudio/emma_supplement/dde_macrophage.RDS

WORKDIR /home/rstudio/emma_supplement
