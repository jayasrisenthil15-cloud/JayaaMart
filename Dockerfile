# Stage 1: Build the WAR file using Maven and JDK 17
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copy project files
COPY . .

# Build the project and skip tests for faster packaging
RUN mvn clean package -DskipTests

# Stage 2: Run on Apache Tomcat 9 with JDK 17
FROM tomcat:9-jdk17

# Remove default Tomcat root applications to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the generated WAR file from build stage and rename it to ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]