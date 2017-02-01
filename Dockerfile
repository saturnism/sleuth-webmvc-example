FROM java:8

RUN mkdir /src
WORKDIR /src

ADD . /src
RUN ./mvnw package

ENTRYPOINT ["./mvnw", "exec:java"]
