FROM bellsoft/liberica-openjdk-alpine:17.0.4.1-1 AS build

ARG publicDependenciesRepositoryUrl
ARG publicPluginsRepositoryUrl

# Build
COPY . ./app/
WORKDIR app
RUN chmod +x gradlew && ./gradlew clean build --stacktrace --no-daemon -DpublicDependenciesRepositoryUrl=${publicDependenciesRepositoryUrl} -DpublicPluginsRepositoryUrl=${publicPluginsRepositoryUrl}

FROM bellsoft/liberica-openjre-alpine:17.0.4.1-1

# Add user scope
RUN mkdir "app" && adduser -D application && chown -R application /app

# Extract application jar
COPY --from=build /app/build/libs/*.jar ./app/app.jar

# Configure application start
USER application
EXPOSE 8080
ENTRYPOINT ["java","-jar","app/app.jar"]