FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y ca-certificates jq git zip

RUN echo "deb [trusted=yes] https://packages.cloudfoundry.org/debian stable main" > /etc/apt/sources.list.d/cloudfoundry-cli.list
RUN apt-get update
RUN apt-get install -y cf-cli

RUN mkdir -p /tmg
WORKDIR /tmg
#RUN git clone https://github.com/dg4101/covid19.git
#WORKDIR /tmg/covid19

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
