FROM rocker/shiny:4.3.0

RUN mkdir -p /srv/shiny-server/app

COPY app.R /srv/shiny-server/app/
COPY data.csv /srv/shiny-server/app/

RUN chmod -R 755 /srv/shiny-server/app

WORKDIR /srv/shiny-server/app

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/app/app.R', host='0.0.0.0', port=3838)"]
