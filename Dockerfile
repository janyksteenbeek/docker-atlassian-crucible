FROM mswinarski/atlassian-base:1.8
MAINTAINER Janyk Steenbeek, opensource@janyksteenbeek.nl

ENV LANG C.UTF-8
ENV FECRU_VERSION 4.8.3
ENV FISHEYE_HOME /atlassian/apps/crucible
ENV FISHEYE_INST /atlassian/data/crucible
ENV FISHEYE_OPTS -Dfecru.configure.from.env.variables=true

# Crucible configuration from environment variables
# ENV FECRU_CONFIGURE_LICENSE_FISHEYE=
# ENV FECRU_CONFIGURE_LICENSE_CRUCIBLE=
# ENV FECRU_CONFIGURE_ADMIN_PASSWORD=
# ENV FECRU_CONFIGURE_DB_TYPE=
# ENV FECRU_CONFIGURE_DB_HOST=
# ENV FECRU_CONFIGURE_DB_PORT=
# ENV FECRU_CONFIGURE_DB_NAME=
# ENV FECRU_CONFIGURE_DB_USER=
# ENV FECRU_CONFIGURE_DB_PASSWORD=
# ENV FECRU_CONFIGURE_DB_MIN_POOL_SIZE=
# ENV FECRU_CONFIGURE_DB_MAX_POOL_SIZE=

RUN echo "Atlassian - Crucible ${FECRU_VERSION} applications runtime environment"

WORKDIR /atlassian/apps

# download and install fisheye to /atlassian/apps/fisheye
ADD http://www.atlassian.com/software/crucible/downloads/binary/crucible-${FECRU_VERSION}.zip /atlassian/apps/

RUN unzip crucible-${FECRU_VERSION}.zip && rm crucible-${FECRU_VERSION}.zip
RUN mv fecru-${FECRU_VERSION} crucible
RUN mkdir -p /atlassian/data/crucible

ADD configure.sh ${FISHEYE_HOME}/
RUN chmod +x ${FISHEYE_HOME}/configure.sh
ADD start.sh ${FISHEYE_HOME}/
RUN chmod +x ${FISHEYE_HOME}/start.sh

VOLUME ${FISHEYE_INST}

EXPOSE 8080

WORKDIR ${FISHEYE_HOME}/

CMD ["./start.sh"]
