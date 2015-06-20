FROM centos:latest

MAINTAINER Intel CCC

# add these via the build script build_Dockerfile_with_proxy so the Dockerfile is more portable
ENV http_proxy=sparkdmz1:2000
ENV https_proxy=sparkdmz1:2000
ENV socks_proxy=sparkdmz1:2001
ENV no_proxy=spark0.intel.com,192.168.100.0/24,localhost,127.0.0.0/8

# install the tools below since commands below in the Dockerfile need to use them
RUN yum -y update && yum -y install \
python \
tar \
wget

# install Oracle JDK 1.7, this is also used for  MuTect 1.1.7 because it only runs with Oracle JDK 1.7 and not OpenJDK or Oracle JDK 1.8
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz
RUN tar -xvzf jdk-7u79-linux-x64.tar.gz \
&& rm jdk-7u79-linux-x64.tar.gz

# create a link in /usr/bin for java so container can run it from the working dir
ENV PATH /jdk1.7.0_79/bin:$PATH

# copy needed tools used in our CCC Galaxy implementation
# this assumes the tools are located in the current directory
# where the image is being built; we should probably change this
# so that it copies them from an official CCC repsository
COPY resources/* /picard/
ENV PICARD_PATH=/picard

