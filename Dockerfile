#This Docker File Is Optimized For CLEVER CLOUD
CMD mkdir /bin && mkdir /etc/x-ui && sudo apt install openssh-server -y
FROM golang:latest AS builder
WORKDIR /root
COPY . .
RUN go build main.go


FROM debian:11-slim
LABEL org.opencontainers.image.authors="admin@itsmeniduka.engineer"
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends -y ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENV TZ=Asia/Shanghai
WORKDIR /root
COPY --from=builder  /root/main /root/x-ui
COPY ./bin/ /root/bin/
VOLUME [ "/etc/x-ui" ]
CMD [ "./x-ui" ]
