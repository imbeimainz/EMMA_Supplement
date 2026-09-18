# Running the FEA analysis with `EMMA` in Docker

1- clone the EMMA_Supplement repository locally

2- Run the following command in the terminal inside the EMMA_Supplement
directory. This command will build a Docker container image:

```
docker build -t emma_supplement .
```

3- To start the container, run :

```
docker run -p 2711:8787 emma_supplement
```

4- Then go to `http://localhost:2711/`

To sign-in, use `username = rstudio`, `password` = displayed in red in the
terminal after running the previous command

5- Inside RStudio server console, create a new folder to run the analysis in
with `dir.create("/home/rstudio/emma_analysis")`
then run `setwd("/home/rstudio/emma_analysis/")`

6- Then open `emma_supplement/EMMA_supplement.qmd`

7- Navigate to section `# Environment restoration and reproducibility check` and
start executing code
