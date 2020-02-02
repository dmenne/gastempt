FROM rocker/shiny-verse:latest

LABEL maintainer="dieter.menne@menne-biomed.de"

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
 libxml2-dev \
 libsqlite-dev \
 libmariadbd-dev \
 libmariadb-client-lgpl-dev \
 libpq-dev \
 libssh2-1-dev \
 libssl-dev  \
 curl \
 libv8-3.14 # for V8

RUN install2.r --error --ncpus 2 \
    devtools \
    PKI \
    caTools \
    DT \
    dygraphs \
    gtools \
    shinyjs \
    shinythemes \
    shinyBS \
    shinyAce \
    shinycssloaders \
    colourpicker \
    xts \
    rsconnect \
    V8 \
    BH

RUN install2.r --error --ncpus 2 \
   Rcpp \
   RcppEigen

RUN install2.r --error --ncpus 2 \
   rstan \
   bayesplot \
   rstantools

# For gitlab
RUN install2.r --error --ncpus 2 \
    ggfittext\
    signal \
    multcomp

RUN Rscript -e "devtools::install_github('dmenne/gastempt')" \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
  && rm -rf /var/lib/apt/lists/*

COPY shiny-server.sh /usr/bin/shiny-server.sh
# https://github.com/rocker-org/shiny/issues/32
RUN ["chmod", "+x", "/usr/bin/shiny-server.sh"]
COPY shiny-server.conf /etc/shiny-server

# Remove apps
RUN rm -R /srv/shiny-server
# Links to gastempt
RUN ln -s  /usr/local/lib/R/site-library/gastempt/shiny /srv/shiny-server
# EXPOSE 3838 # already in stanverse
HEALTHCHECK --interval=60s CMD curl --fail http://localhost:3838 || exit 1

CMD ["/usr/bin/shiny-server.sh"]

