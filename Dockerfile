FROM jzmatrix/debian-baseimage
################################################################################
RUN apt update && \
    apt -y install libyaml-tiny-perl liblwp-protocol-https-perl libjson-perl libdbd-mysql-perl libdbi-perl libcryptx-perl libmime-lite-html-perl libmime-tools-perl libmail-imapclient-perl libdate-calc-perl curl libdbd-sqlite3-perl

##
RUN  apt-get autoremove && \
     apt-get clean && \
     apt-get autoclean && \
     rm -rf /var/lib/apt/lists/* && \
     mkdir /opt/sslUpdate && \
     mkdir /var/run/sshd && \
     chmod 0755 /var/run/sshd && \
     mkdir /opt/readKik
################################################################################
# ADD config/authorized_keys /root/.ssh/authorized_keys
ADD config/startServices.sh /opt/startServices.sh
# ADD config/bash_profile /root/.bash_profile
################################################################################
RUN chmod 755 /opt/startServices.sh
################################################################################
ADD scripts /opt/readKik/
RUN chmod 755 -R /opt/readKik/
################################################################################
CMD ["/opt/readKik/readData"]   # Used when deployed
# CMD [ "/opt/startServices.sh" ] # Only used for dev and testing
