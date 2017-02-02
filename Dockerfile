FROM swift:3.0
RUN apt-get update \
    && apt-get install -y openssl libssl-dev \
    && rm -r /var/lib/apt/lists/*

WORKDIR /code
ARG BUILD_CONFIGURATION=debug

COPY Package.swift /code/
RUN swift build -c $BUILD_CONFIGURATION || true

COPY ./Sources /code/Sources
RUN swift build -c $BUILD_CONFIGURATION

EXPOSE 8000
ENV BUILD_CONFIGURATION $BUILD_CONFIGURATION
CMD .build/$BUILD_CONFIGURATION/App
