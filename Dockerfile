FROM tomcat:10.1-jdk17-temurin

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/local/tomcat/webapps/*

COPY app-source.zip /tmp/app-source.zip
RUN unzip -q /tmp/app-source.zip -d /tmp/app \
    && cp -a /tmp/app/build/web/. /usr/local/tomcat/webapps/ROOT/ \
    && rm -rf /tmp/app /tmp/app-source.zip

EXPOSE 8080
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
