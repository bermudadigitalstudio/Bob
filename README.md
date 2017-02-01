# Bob
Bob's your uncle.

## What is Bob?

Bob is a collection of scripts and Dockerfiles that we have found useful in developing Swift apps for Linux environments on the server. You use Bob by copying these scripts into your repo and committing them as part of your source code. See [the instructions](Installation instructions) to get started.

## What do you get with Bob?

Bob relies on Swift project conventions, like `swift build` and `swift test`, to enable it to enhance your server side Swift project.

#### Dockerfile
An opinionated Dockerfile for your server side Swift app, leveraging Docker layer caching for faster build times.

This Dockerfile installs openssl (because Kitura...), copies your Package.swift and prefetches and compiles dependencies. It then copies your source code, builds the app again. Changes to your source code will only result in recompilation of your project, not the dependencies.

> The image's startup command assumes your project compiles a server named `App` that listens on port 8000.

##### Usage 

```
docker build . -t my-cool-app
# By default, a debug build is used (Swift is surprisingly fast in Debug!). You can do this too:
docker build . -t my-cool-app --build-arg BUILD_CONFIGURATION=release

docker run my-cool-app
```

## Installation instructions

Unpack the contents of this repo into a subdirectory of your current directory and run the bootstrap script.

```bash
mkdir tmp-bob \
  && cd tmp-bob \
  && curl -sL https://github.com/bermudadigitalstudio/Bob/archive/master.tar.gz | tar -xzk --strip-components 1 \
  && cd .. \
  && tmp-bob/bootstrap.sh
```
