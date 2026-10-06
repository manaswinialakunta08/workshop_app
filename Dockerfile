# ---- Hardened Dockerfile for workshop-app ----

FROM eclipse-temurin:21-jre-alpine

RUN addgroup -S app && adduser -S -G app app

WORKDIR /app

COPY --chown=app:app target/workshop-app.jar app.jar

USER app

EXPOSE 8081

HEALTHCHECK --interval=30s --timeout=5s --start-period=40s --retries=3 \
  CMD wget -qO- http://localhost:8081/actuator/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]
