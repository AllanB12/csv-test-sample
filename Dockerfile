FROM rocker/shiny:4.3.2

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN R -q -e "install.packages(c('shiny'), repos='https://cran.rstudio.com/', quiet=TRUE)"

RUN mkdir -p /srv/shiny_app /data \
    && chgrp -R 0 /srv/shiny_app /data \
    && chmod -R g+rwX /srv/shiny_app /data

COPY app.R /srv/shiny_app/

WORKDIR /srv/shiny_app

EXPOSE 8080

CMD ["R", "-e", "shiny::runApp('/srv/shiny_app/app.R', host='0.0.0.0', port=8080)"]
