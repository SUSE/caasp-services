#!/bin/bash

openssl genrsa -out ./secrets/portus.key 3072
openssl req -new -x509 -key ./secrets/portus.key -sha256 -out ./secrets/portus.crt -days 9999 -config ./openssl.cnf -subj "/C=US/ST=WA/L=SUSE/O=Seattle/CN=nginx.portus.svc.cluster.local"
