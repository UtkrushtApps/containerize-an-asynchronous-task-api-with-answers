# Start from an official OpenJDK runtime as a parent image
FROM eclipse-temurin:17-jre-alpine as base

# Set environment variables
ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    JAVA_OPTS=""

# Add a non-root user to run our application
RUN addgroup -S spring && adduser -S spring -G spring

# Make dirs for app and logs
RUN mkdir /app && mkdir -p /app/logs && chown -R spring:spring /app

WORKDIR /app

# Copy jar file
COPY target/async-api.jar app.jar

# Set permissions
RUN chown spring:spring /app/app.jar

# Switch to the non-root user
USER spring

# Expose port (assumes Spring Boot default, adjust if needed)
EXPOSE 8080

# Mount volume for persistent logs
VOLUME ["/app/logs"]

# Default Java options & output log to logs directory
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar > /app/logs/app.log 2>&1"]
