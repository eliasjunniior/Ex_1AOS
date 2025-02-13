#
# Build stage
#
FROM maven:3.9-eclipse-temurin AS build

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

#
# Package stage
#
FROM eclipse-temurin:23-jdk-alpine 
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
