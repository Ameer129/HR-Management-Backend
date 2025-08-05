# Use an official OpenJDK runtime as base image
# Stage 1: Build the project
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /build

# Copy only the project directory
COPY hrms-backend-master /build

# Build the project
RUN mvn clean package -DskipTests

# Stage 2: Run the app
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /build/target/hrms-backend-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

