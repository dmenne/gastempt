FROM rocker/r-base:latest

LABEL maintainer="dieter.menne@menne-biomed.de"


RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libv8-dev \
  libxml2-dev \
  libcurl4-openssl-dev \
  libgit2-dev \
  curl

RUN mkdir -p ~/.R
COPY ./Makevars /root/.R/Makevars

RUN install2.r --error --ncpus 2 --skipinstalled \
    DT \
    gtools \
    shinyjs \
    shinythemes \
    shinyAce \
    shinycssloaders \
    curl \
    xml2 \
  	V8 \
    httr \
    readxl \
    remotes \
    rstan \
    bayesplot \
    rstantools

RUN R -e 'remotes::install_github("JohnCoene/tippy")'

RUN Rscript -e "remotes::install_github('dmenne/gastempt')" \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
  && rm -rf /var/lib/apt/lists/*


EXPOSE 3838
HEALTHCHECK --interval=60s  --start-period=20s CMD curl --fail http://localhost:3838 || exit 1

CMD ["R", "-e", \
 "shiny::runApp(system.file('shiny', package = 'gastempt'), \
   host = '0.0.0.0', port = 3838)"]


