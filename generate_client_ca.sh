#!/usr/bin/env bash
#Client hostname
CLIENT_CN=localhost

echo Generating client key...
openssl genrsa -out client.key 4096

echo Generating client Certificate Signing Request...
openssl req -new -key client.key -out client.csr -subj "/CN=${CLIENT_CN}"

echo Generating client certificate signed by the self-signed CA...
openssl x509 -req -in client.csr -CA rootCA.crt -CAkey rootCA.key -set_serial 02 -out client.crt -days 365 -sha256

echo Converting client private key to X.509, so use client.pem...
openssl pkcs8 -topk8 -nocrypt -in client.key -out client.pem

echo Do not forget to add the server hostname, i.e. localhost, to your client /etc/hosts
