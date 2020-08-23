#!/bin/sh

/bin/brook socks5tohttp -s ${HOST}:${PORT} -l 0.0.0.0:8081
echo "exit code: $?"
