# ![RealWorld Example App](quarkus-logo.png)

> ### Quarkus Framework codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the [RealWorld](https://github.com/gothinkster/realworld) spec and API.

This codebase was created to demonstrate a fully fledged fullstack application built with [Quarkus](https://quarkus.io/)
including CRUD operations, authentication, routing, pagination, and more.

We've gone to great lengths to adhere to the Quarkus community styleguides & best practices.

For more information on how to this works with other frontends/backends, head over to
the [RealWorld](https://github.com/gothinkster/realworld) repo.

[![Build Status](https://travis-ci.org/diegocamara/realworld-api-quarkus.svg?branch=master)](https://travis-ci.org/diegocamara/realworld-api-quarkus)

# How it works

This application basically uses Quarkus Framework with Java 11 with some other modules known to development community:

* Hibernate 5
* Jackson for JSON
* H2 in memory database
* JPA Criteria
* Auth0 java-jwt

### Project structure:

```
application/            -> business orchestration layer
+-- web/                -> web layer models and resources
domain/                 -> core business implementation layer
+-- model/              -> core business entity models
+-- feature/            -> all features logic implementation
+-- validator/          -> model validation implementation 
+-- exception/          -> all business exceptions
infrastructure/         -> technical details layer
+-- configuration/      -> dependency injection configuration
+-- repository/         -> adapters for domain repositories
+-- provider/           -> adapters for domain providers
+-- web/                -> web layer infrastructure models and security
```

# Getting started

### Start local server

```bash
./mvnw compile quarkus:dev -Dquarkus.profile=h2
 ```

The server should be running at http://localhost:8080

Note the default profile it will expect postgres to be running. You need to use `-Dquarkus.profile=h2` to 
start with an in-memory database. See how to run postgres in docker-compose below.  

### Running the application tests

``` 
./mvnw test 
```

### Running postman collection tests

First ensure that you are running the app with profile 'h2' then run the tests with:

```
./collections/run-api-tests.sh
```

### Building and running jar with docker-compose

```
./mvnw clean package -Dmaven.test.skip=true -Dquarkus.package.type=legacy-jar
docker-compose up --build
```

### Building and running native executable with docker-compose

```
# this runs docker to compile the app. you will need to allocate more CPU and 5G to docker
# it might take 15 minutes to compile the 60MB app. 
./native-build.sh
docker-compose -f docker-compose-native.yml up --build
```

#### Database Changes

The database properties within `application.propeties` use postgres and env vars `DB_URL`, `DB_USER` and `DB_PASS`:

```properties
quarkus.datasource.db-kind=postgresql
quarkus.datasource.jdbc.driver=org.postgresql.Driver
quarkus.datasource.jdbc.url=${DB_URL:jdbc:postgresql://localhost:5432/postgres}
quarkus.datasource.username=${DB_USER:postgres}
quarkus.datasource.password=${DB_PASS:123456}
```

See `docker-compose.yml` as a fully working example. 

## Help

Improvements are welcome, feel free to contribute.
