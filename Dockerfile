# --------- Build stage using Java 24 ---------
FROM eclipse-temurin:24 AS build
WORKDIR /app

# Install Maven manually since Maven + Java 24 image doesn't exist
RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean

COPY . .
RUN mvn clean package -DskipTests

# --------- Run stage ---------
FROM eclipse-temurin:24-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
