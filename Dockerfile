FROM centos:latest
MAINTAINER "Surisetty, Naresh <naresh@naresh.co>"

ENV ORACLE_HOME=/usr/lib/oracle/11.2/client64

COPY instantclient/* /tmp/

RUN \
  yum -y update && \
  yum -y install libaio gcc && \
  yum -y install epel-release && \
  yum -y install centos-release-scl && \
  yum -y install python27 python27-devel python27-setuptools && \
  rpm -ivh /tmp/oracle-instantclient*.rpm && \
  mkdir -p /usr/lib/oracle/11.2/client64/network/admin/ && \
  echo "/usr/lib/oracle/11.2/client64/lib" > /etc/ld.so.conf.d/oracle.conf && \
  ldconfig

RUN cd /opt/rh/python27/root/usr/bin/
RUN printenv LD_LIBRARY_PATH
RUN LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./easy_install-2.7 pip
RUN LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./pip2.7 install cx_Oracle
