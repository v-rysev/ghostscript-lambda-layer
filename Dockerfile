FROM lambci/lambda-base-2:build
ARG GS_TAG
ARG GS_VERSION

ENV GS_TAG=$GS_TAG
ENV GS_VERSION=$GS_VERSION

RUN yum install -y wget

RUN mkdir /usr/local/src/ghostscript && \
  cd /usr/local/src/ghostscript && \
  wget -qO - https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/$GS_TAG/ghostscript-$GS_VERSION.tar.gz | tar -zxf - && \
  cd ghostscript-$GS_VERSION && \
  ./configure --without-luratech && \
  make && make install

RUN cd /usr/local && \
  zip /tmp/gs.zip bin/gs
