FROM debian:latest

MAINTAINER Tobias Hofmann <t...@gmail.com>

LABEL version="1.0"
LABEL description="Docker image for SAP Web Dispatcher installation with SWMP and sapinst“

# create new user
RUN useradd --create-home --shell /bin/bash wddadm
RUN echo 'wddadm:whatever' | chpasswd

# copy SAP files to image
COPY SAPCAR.EXE /home/wddadm/sapcar
COPY SAPWEBDISP.SAR /home/wddadm/
COPY SWPM.SAR /home/wddadm/
COPY SAPHOSTAGENT.SAR /home/wddadm/

# make sapcar executable
RUN chown wddadm /home/wddadm/*
RUN chmod 700 /home/wddadm/sapcar

# expose ports
EXPOSE 21212
EXPOSE 44300

# unsapcar content of SWPM
WORKDIR /home/wddadm
RUN /home/wddadm/sapcar -xvf /home/wddadm/SWPM.SAR
