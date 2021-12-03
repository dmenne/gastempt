FROM rocker/r-base:latest

LABEL maintainer="dieter.menne@menne-biomed.de"


RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libv8-dev \
  libxml2-dev \
  libcurl4-openssl-dev \
  curl


RUN install2.r --error --ncpus 2 --deps TRUE --skipinstalled \
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
    remotes


RUN mkdir -p ~/.R
RUN echo "CXX14FLAGS=-O3 -Wno-unused-variable -Wno-unused-function  -Wno-macro-redefined -Wno-deprecated-declarations -Wno-ignored-attributes" >> ~/.R/Makevars


RUN install2.r --error --ncpus 6 --skipinstalled \
   rstan \
   bayesplot \
   rstantools

RUN Rscript -e "remotes::install_github('dmenne/gastempt')" \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
  && rm -rf /var/lib/apt/lists/*

RUN install2.r --error --ncpus 2 --deps TRUE --skipinstalled \
  readxl

EXPOSE 3838
HEALTHCHECK --interval=60s  --start-period=20s CMD curl --fail http://localhost:3838 || exit 1

CMD ["R", "-e", \
 "shiny::runApp(system.file('shiny', package = 'gastempt'), \
   host = '0.0.0.0', port = 3838)"]


