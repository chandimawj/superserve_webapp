FROM openjdk:8
COPY ./build/libs/serving-web-content-0.0.1.jar /usr/app/
WORKDIR /usr/app
EXPOSE 8888
ENTRYPOINT ["java", "-jar", "serving-web-content-0.0.1.jar"]
