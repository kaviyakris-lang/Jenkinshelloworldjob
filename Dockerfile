# Stage 1: Build and run Java program
FROM openjdk:17-alpine AS builder

# Set working directory
WORKDIR /app

# Copy Java source
COPY Helloworld.java .

# Compile Java
RUN javac Helloworld.java

# Run Java and save output to index.html
RUN java HelloWorld > index.html

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Remove default Nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy generated HTML from builder stage
COPY --from=builder /app/index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
