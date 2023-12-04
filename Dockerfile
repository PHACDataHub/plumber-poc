FROM rstudio/plumber
LABEL org.opencontainers.image.authors="Docker User <docker@user.org>"

RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('readr')"
RUN R -e "install.packages('workflows')"
RUN R -e "install.packages('glmnet')"
RUN R -e "install.packages('recipes')"

# copy everything from the current directory into the container
COPY / /

# open port 8000 to traffic
EXPOSE 8080

# when the container starts, start the API.R script
ENTRYPOINT ["Rscript", "API.R"]