# Bob
Bob's your uncle.

## What is Bob?

Bob is a collection of scripts and Dockerfiles that we have found useful in developing Swift apps for Linux environments on the server. You use Bob by copying these scripts into your repo and committing them as part of your source code. See [the instructions](#installation-instructions) to get started.

## What do you get with Bob?

Bob relies on Swift project conventions, like `swift build` and `swift test`, to enable it to enhance your server side Swift project.

### Dockerfile
An opinionated Dockerfile for your server side Swift app, leveraging Docker layer caching for faster build times.

This Dockerfile installs openssl (because Kitura...), copies your Package.swift and prefetches and compiles dependencies. It then copies your source code, builds the app again. Changes to your source code will only result in recompilation of your project, not the dependencies.

> The image's startup command assumes your project compiles a server named `App` that listens on port 8000.

```bash
docker build . -t my-cool-app
# By default, a debug build is used (Swift is surprisingly fast in Debug!). You can do this too:
docker build . -t my-cool-app --build-arg BUILD_CONFIGURATION=release

docker run my-cool-app
```

### .gitignore and .dockerignore
A slightly modified .gitignore than the one provided by `swift package init`, and a .dockerignore file that is simply a symlink of the .gitignore.

### Scripts/mirror.sh
A small shell script that drops you into a mirror of your Swift project in a Linux container. The container is a Swift container with openssl preinstalled.

All changes to your local Swift project will be instantly reflected in your container. This is useful for coding in Xcode but checking your tests work on Linux.

> The container is deleted after every run. It is recommended that your run this script in a separate terminal and keep it open.

```bash
swizzair:query swizzlr$ ./Scripts/mirror.sh 
+ docker build -t swift-3.1 -
Sending build context to Docker daemon 2.048 kB
SNIP
Successfully built fe436e359284
+ docker run --rm -it -w /code -v /Users/swizzlr/github/titan/query/Sources:/code/Sources -v ... SNIP
root@ac8026b72484:/code# swift test
Cloning https://github.com/bermudadigitalstudio/TitanCore.git
HEAD is now at 584bfef Remove unnecessary code.
SNIP
```

### Scripts/test.sh
A special `Dockerfile~test` is used which copies files and caches fetched packages but does no compilation. The run command is `swift test`, and a bit of extra code on the end ensures that if the container's test runner crashes, an alert in red is printed and a bell is played to [avoid the useless output currently provided by swift test](https://bugs.swift.org/browse/SR-3822).

```bash
./Scripts/test.sh
```

### Scripts/generate_LinuxMain.sh
Auto generate a LinuxMain file using Sourcery and the LinuxMain template. This script requires you to have Sourcery installed, and will prompt you if you do not.

On first run, you will see an error asking you to edit the script – the one thing Sourcery can't detect is the name of your test target, e.g. `MyCoolAppTests`. Edit it that, and you're good to go.

```bash
./Scripts/generate_LinuxMain.sh
```

## Installation instructions

Use `swift package init` to get started if you don't yet have a project, and `cd` into the project. Ensure you've got everything you want committed, since this installation is semi-destructive!

Unpack the contents of this repo into a subdirectory of your current directory and run the bootstrap script. If you're lazy, copy and paste the below command.

The bootstrap script automatically deletes its enclosing folder, so no cleanup is necessary.

```bash
mkdir tmp-bob \
  && cd tmp-bob \
  && curl -sL https://github.com/bermudadigitalstudio/Bob/archive/master.tar.gz | tar -xzk --strip-components 1 \
  && cd .. \
  && tmp-bob/bootstrap.sh
```
