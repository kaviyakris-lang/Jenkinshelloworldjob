# Stage 1: Build Java application (optional if you already have the JAR)
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app
# Copy your Java source or JAR
COPY hello-world-1.0-SNAPSHOT.jar /app/hello-world-1.0-SNAPSHOT.jar

# Stage 2: Final image with NGINX + Java
FROM nginx:1.25-alpine

# Install OpenJDK runtime
RUN apk add --no-cache openjdk17

# Set working directory for Java app
WORKDIR /app

# Copy JAR from builder stage
COPY --from=builder /app/hello-world-1.0-SNAPSHOT.jar /app/hello-world-1.0-SNAPSHOT.jar

# Copy NGINX config (optional custom reverse proxy)
COPY nginx.conf /etc/nginx/nginx.conf

# Copy static files (if any) to NGINX html directory
# COPY static/ /usr/share/nginx/html/

# Expose ports: 80 for NGINX, 8080 for Java app
EXPOSE 80 8080

# Start both NGINX and Java app
CMD sh -c "nginx && java -jar /app/hello-world-1.0-SNAPSHOT.jar"
