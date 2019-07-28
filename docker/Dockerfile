FROM openjdk:11-jre-slim

COPY Users-0.0.1-SNAPSHOT.jar /app.war

#CMD ["java", "-version"]

CMD ["java", "-jar", "-Dspring.profiles.active=default", "/app.war"]