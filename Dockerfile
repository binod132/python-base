FROM python:3.10-buster

LABEL maintainer = "binod.adhikari.treeleaf@gmail.com"
LABEL description="Python base image"
LABEL version="1.0"
LABEL vendor="Treeleaf"

ENV LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8 LANG=C.UTF-8
ENV GCSFUSE_REPO gcsfuse-stretch

RUN mkdir -p /app
#RUN pip install cx-Oracle
RUN apt-get -y update && apt-get install -y vim netcat bash make curl tini wget cmake unzip build-essential libsm6 libxext6 libxrender-dev libglib2.0-0 alien

RUN wget https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-basic-linux.x64-21.4.0.0.0dbru.zip
RUN wget https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-sqlplus-linux.x64-21.4.0.0.0dbru.zip 

RUN mkdir -p /opt/oracle
RUN unzip -d /opt/oracle instantclient-basic-linux.x64-21.4.0.0.0dbru.zip
RUN unzip -d /opt/oracle instantclient-sqlplus-linux.x64-21.4.0.0.0dbru.zip
RUN apt-get install libaio1 libaio-dev
RUN export LD_LIBRARY_PATH=/opt/oracle/instantclient_21_4:$LD_LIBRARY_PATH && \
    export PATH=$LD_LIBRARY_PATH:$PATH && \
    ls -al && \
    . ~/.bashrc
RUN ldconfig

COPY requirements.txt /app
WORKDIR /app
RUN pip install --upgrade pip setuptools && pip install -r requirements.txt