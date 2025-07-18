
FROM eclipse-temurin:24 AS build
WORKDIR /app

RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean

COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:24-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
