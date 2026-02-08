FROM scratch AS ctx

COPY --chmod=755 build-base.sh /
COPY --chmod=755 build-extra.sh /
COPY --chmod=755 build-test.sh /

FROM quay.io/fedora/fedora-bootc:latest

COPY --chmod=755 config.toml /etc/greetd/config.toml

#RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
#    --mount=type=cache,dst=/var/cache \
#    --mount=type=cache,dst=/var/log \
#    --mount=type=tmpfs,dst=/tmp \
#    /ctx/build-base.sh

#RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
#    --mount=type=cache,dst=/var/cache \
#    --mount=type=cache,dst=/var/log \
#    --mount=type=tmpfs,dst=/tmp \
#    /ctx/build-extra.sh

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build-test.sh

RUN bootc container lint
