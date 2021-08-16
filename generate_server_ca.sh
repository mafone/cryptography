#!/usr/bin/env bash
#Server hostname to be added to clients' /etc/hosts
SERVER_CN=localhost

echo Generating CA key and self-sined certificate...
openssl req -nodes -batch -x509 -days 358000 -sha256 -newkey rsa:4096 -keyout rootCA.key -out rootCA.crt -subj "/CN=${SERVER_CN}"

echo Generating server key...
openssl genrsa -out server.key 4096

echo Generating server Certificate Signing Request...
openssl req -new -key server.key -out server.csr -subj "/CN=${SERVER_CN}"

echo Generating  server certificate signed by the self-signed CA...
openssl x509 -req -in server.csr -CA rootCA.crt -CAkey rootCA.key -set_serial 01 -out server.crt -days 365 -sha256

echo Converting server private key to X.509, so use server.pem...
openssl pkcs8 -topk8 -nocrypt -in server.key -out server.pem

echo Do not forget to send your rootCA.crt and rootCA.key to you client via scp
