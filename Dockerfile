FROM alpine:3.11.6

LABEL maintainer="Ztj <ztj1993@gmail.com>"

ENV HOST=127.0.0.1
ENV PORT=1080

ARG BROOK_VERSION="v20200901"
ARG BROOK_CHECKSUM="a4f3cdd34dd2ecc7c031144b4d07b43b"

ADD https://github.com/txthinking/brook/releases/download/${BROOK_VERSION}/brook_linux_amd64 /bin/brook
ADD ./entrypoint.sh /bin/entrypoint.sh

RUN FILE_MD5=$(md5sum /bin/brook | awk '{print $1}') \
  && echo "Host: ${HOST}" \
  && echo "Port: ${PORT}" \
  && echo "Version: ${BROOK_VERSION}" \
  && echo "CheckSum: ${BROOK_CHECKSUM}" \
  && echo "FileMD5: ${FILE_MD5}" \
  && if [ "${BROOK_CHECKSUM}" != "${FILE_MD5}" ]; then exit 1; fi \
  && chmod +x /bin/brook \
  && /bin/brook socks5tohttp --help \
  && chmod +x /bin/entrypoint.sh

EXPOSE 8081

CMD ["/bin/entrypoint.sh"]
