FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y ca-certificates jq git curl

RUN curl -sL --insecure https://deb.nodesource.com/setup_10.x -o /nodesource_setup.sh
RUN chmod 755 /nodesource_setup.sh
RUN /nodesource_setup.sh

RUN echo "deb [trusted=yes] https://packages.cloudfoundry.org/debian stable main" > /etc/apt/sources.list.d/cloudfoundry-cli.list
RUN echo "deb [trusted=yes] https://dl.yarnpkg.com/debian/ stable main"  > /etc/apt/sources.list.d/yarn-cli.list
RUN apt-get update
RUN apt-get install -y cf-cli yarn

RUN mkdir -p /tmg
WORKDIR /tmg
RUN git clone https://github.com/dg4101/covid19.git
WORKDIR /tmg/covid19
RUN pwd
RUN find .
RUN yarn install
#RUN yarn dev

RUN which cf;nodejs -v
ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
