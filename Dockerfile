FROM maven:3.5.4-jdk-8
MAINTAINER mtons

WORKDIR /app/mblog
ADD . /build

ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/{TZ} /etc/localtime && echo "{TZ}" > /etc/timezone

RUN cd /build && mvn package -Dmaven.test.skip=true -Pmysql
# \&& cp -f target/mblog-latest.jar /app/mblog && rm -rf /build/*
COPY target/mblog-latest.jar /app/mblog/
RUN rm -rf /build/*

EXPOSE 8088

ENTRYPOINT ["java","-jar","/app/mblog/mblog-latest.jar"]