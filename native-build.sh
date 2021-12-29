#!/bin/bash
#
# note quarkus 2.6.1.Final native build does not work on GraalVM 21.3.0 (Java 17) as it tries to set a legacy
# SVM GC option that cannot be overloaded. So in this script we replace the generated native-image.args
# with a hand edited one that has no 'InitialCollectionPolicy' so that SVM uses it's default.
#
# note that my M1 macbook takes 5 minutes to use docker to compile the binary having increased docker desktop resource
# to 5 CPU, 5 GB and 2.5 G swap. also i have to restart docker desktop between executions else it slows down to a crawl
#
set -x
./mvnw package -Dmaven.test.skip=true -Dquarkus.package.type=native-sources 
cp native-image.args target/native-sources/
pushd target/native-sources
time docker run -it --rm -v $(pwd):/work -w /work --entrypoint /bin/sh ghcr.io/graalvm/native-image -c "native-image $(cat native-image.args) -J-Xmx5g"
popd
mv target/native-sources/realworld-api-quarkus-runner target/
