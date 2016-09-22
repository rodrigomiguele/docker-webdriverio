FROM node

RUN mkdir /app

RUN apt-get update && \
    apt-get install -y openjdk-7-jdk

RUN curl -O http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.1.jar && \
    mv selenium-server*.jar /opt/selenium-server.jar

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    bunzip2 phantomjs-*.tar.bz2 && \
    tar -xf phantomjs-*.tar && \
    rm -f phantomjs-*.tar && \
    mv phantomjs-* /opt/phantomjs/

ENV PATH $PATH:/opt/phantomjs/bin

RUN npm install -g webdriverio cucumber@1.3.0 wdio-cucumber-framework wdio-json-reporter wdio-junit-reporter

RUN useradd -ms /bin/bash developer

USER developer

ENV HOME /home/developer

ENV OUTPUTDIR /home/developer/app/outputDir

ENV ERRORSHOTS /home/developer/app/errorShots

WORKDIR /home/developer/app

COPY logging.properties /opt/

COPY run-tests /usr/local/bin

ENTRYPOINT run-tests
