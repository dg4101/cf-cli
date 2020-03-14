FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y ca-certificates jq git

RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
RUN echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list

RUN apt-get update
RUN apt-get install -y cf-cli
RUN which cf

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]