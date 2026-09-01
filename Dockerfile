# =============================================================
# Stage 1: Build the Spring Boot application (JAR using Maven)
# ============================================================

# Maven + Java 17 image for building the application
FROM maven:3.9-eclipse-temurin-17 As builder

# Set working directory inside the container
WORKDIR /app

# Copy the src directory from our local project into /app/src inside the container
COPY . .

# Build the JAR file and skip tests
RUN mvn clean package -DskipTests


# ==========================================
# Stage 2: Run the Spring Boot application
# ==========================================

# Java 17 runtime image for running the JAR
FROM eclipse-temurin:17-jre

# Set working directory inside the container
WORKDIR /app

# Copy the JAR from Stage 1
COPY --from=builder /app/target/*.jar  app.jar

# Expose Spring Boot application port
EXPOSE 8000

# Start the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]



