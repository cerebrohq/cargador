from debian:10

LABEL "Copyright"="Cerebro Inc"
LABEL "Support_email" = "support@cerebrohq.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
	python3.5 \
    python3-pip \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
	
RUN apt-get update && apt-get install -y libpq-dev python3-dev gcc
RUN pip3 install setuptools
RUN pip3 install psycopg2-binary

RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN export LANG=en_US.UTF-8

#RUN apt-get install -y software-properties-common
#RUN add-apt-repository ppa:jonathonf/ffmpeg-4 
RUN apt-get install -y ffmpeg

RUN apt-get install -y mc

RUN mkdir -p /cerebro
RUN mkdir -p /cerebro/cargador
RUN mkdir -p /cerebro/backup
RUN mkdir -p /cerebro/cerebro.files
RUN mkdir -p /cerebro/logs
RUN mkdir -p /config
RUN mkdir -p /config/.system
RUN mkdir -p /config/ssl

# config symlinks
RUN ln -s /config/cargador.linux.conf /cerebro/cargador/cargador.linux.conf
RUN ln -s /config/main.conf /cerebro/cargador/main.conf
RUN ln -s /config/cron_conf.py /cerebro/cargador/cron_conf.py

ADD cargador /cerebro/cargador

WORKDIR /cerebro/cargador
CMD ./cargador.linux64