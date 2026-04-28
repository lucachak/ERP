# Build stage
FROM maven:3.9-eclipse-temurin-21-alpine AS build
WORKDIR /app
# Copia apenas o pom.xml primeiro para baixar as dependências (cache)
COPY pom.xml .
RUN mvn dependency:go-offline -B
# Agora copia o código fonte e compila
COPY src ./src
RUN mvn clean package -DskipTests

# Run stage
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
# A porta será passada pela variável de ambiente PORT (usada no Render)
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
