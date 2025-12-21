# Use official Tomcat base image
FROM tomcat:10.1-jdk17

COPY myapp.war C:\Program Files\tomcat\webapps/

# Expose Tomcat port
EXPOSE 8081

# Start Tomcat
CMD ["catalina.sh", "run"]
