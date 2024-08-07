FROM maven:3.8.5-openjdk-17 AS mave

## Build in developer's local machine.
FROM maven AS build-local
COPY . /sources
WORKDIR /build
RUN mvn -f /sources/pom.xml -DskipTests clean verify
RUN cp /sources/target/*.jar ./application.jar

## Extract built jar file into layers
FROM build-local AS extractor
WORKDIR /build/layers
RUN java -Djarmode=layertools -jar /build/application.jar extract

## Create final docker image.
FROM gcr.io/distroless/java17-debian12
WORKDIR /app
COPY --from=extractor build/layers/dependencies/ ./
COPY --from=extractor build/layers/spring-boot-loader ./
COPY --from=extractor build/layers/snapshot-dependencies/ ./
COPY --from=extractor build/layers/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]
