FROM swift:4.0

WORKDIR /code
ARG BUILD_CONFIGURATION=debug

# PREBUILD DEPENDENCIES (Optional)
#
# Use the following procedure to compile your dependencies and cache them in
# a separate docker layer.

# Uncomment the following to create 'dummy' targets
# These must match your 'Package.swift' target definition exactly.
# RUN mkdir /code/Sources \
#   /code/Sources/Server \
#   # /code/Sources/MyLib \ etc
#   find /code/Sources/* -type d -exec sh -c 'touch "$0/main.swift"' {} \;

COPY Package.swift Package.resolved /code/
RUN swift build --enable-prefetching -c $BUILD_CONFIGURATION || true

RUN rm -r /code/Sources || true # in case of prebuilt deps, effectively a no-op otherwise
COPY ./Sources /code/Sources
RUN swift build -c $BUILD_CONFIGURATION

EXPOSE 80
ENV BUILD_CONFIGURATION $BUILD_CONFIGURATION
CMD .build/$BUILD_CONFIGURATION/Server
