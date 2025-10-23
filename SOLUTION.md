# Solution Steps

1. Create a Dockerfile using a slim OpenJDK (like eclipse-temurin:17-jre-alpine) as the base image.

2. Create a non-root user to run the Spring Boot application for better security.

3. Set the working directory (e.g., /app) and ensure directories exist for logs.

4. Copy the built Spring Boot fat JAR (typically named async-api.jar or similar) into the container's app directory.

5. Expose the default Spring Boot port (8080).

6. Set up a volume for persistent logs by mounting /app/logs.

7. Configure the ENTRYPOINT to run the JAR with any provided JAVA_OPTS and redirect stdout/stderr to a file in /app/logs/app.log.

8. Create a .dockerignore file to prevent copying unnecessary local files (e.g., target, .git, IDE files, logs) into the Docker build context.

9. Build a docker-compose.yml that defines the service, ports, environment variables, log/volume mounting, and container resource limits.

10. Map the host's ./logs directory to the container's /app/logs directory to make logs persist and easily available on the host.

11. In docker-compose.yml, limit the container's memory (limits: 600M, reservations: 256M) and ensure service restarts unless stopped.

12. With this setup, you can build and run the app using `docker-compose up --build`, and logs will be found in ./logs on the host side.

