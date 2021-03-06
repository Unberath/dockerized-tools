#################################################################
# Dockerfile
#
# Software:         Oncodrive FM
# Software Version: 1.0.1
# Description:      OncodriveFM detects candidate cancer driver genes and 
#                   pathways from catalogs of somatic mutations in a cohort 
#                   of tumors by computing the bias towards the accumulation of 
#                   functional mutations (FM bias).This novel approach avoids 
#                   some known limitations of recurrence-based approaches, 
#                   such as the difﬁculty to estimate background mutation rate, 
#                   and the fact that they usually fail to identify lowly 
#                   recurrently mutated driver genes.
# Website:          https://bitbucket.org/bbglab/oncodrivefm
# Base Image:       ubuntu 14.04
# Run Cmd:          docker run oncodrivefm oncodrivefm --help
#################################################################
FROM ubuntu:14.04

MAINTAINER Adam Struck <strucka@ohsu.edu>

USER root
 
RUN apt-get update && \
    apt-get install -y \
    curl \    
    tk \
    python3 python3-pip python3-tk \
    libpng-dev \
    libfreetype6-dev \
    libblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    pep8 \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

Run pip3 install -U pip
RUN pip3 install numpy==1.11.2
RUN pip3 install scipy==0.18.1
RUN pip3 install pandas==0.18.1
RUN pip3 install statsmodels==0.6.1
RUN pip3 install matplotlib==1.5.3

WORKDIR /tmp/
RUN curl -L -o tmp.tar.gz https://bitbucket.org/bbglab/oncodrivefm/get/1.0.1.tar.gz && \
    mkdir oncodriveFM && \
    tar -C oncodriveFM --strip-components=1 -xzf tmp.tar.gz && \
    cd oncodriveFM && \
    python3 setup.py install && \
    cd /tmp/ && \
    rm -rf *


# To get rid of:
### /usr/local/lib/python3.4/dist-packages/matplotlib/font_manager.py:273: 
### UserWarning: Matplotlib is building the font cache using fc-list. This may take a moment.
### warnings.warn('Matplotlib is building the font cache using fc-list. This may take a moment.')
RUN oncodrivefm -h

WORKDIR /home/
VOLUME /home/

CMD ["oncodrivefm"]
