#!/bin/sh

echo "!!!Install xray server!!!"

echo "Check XRay-obfuscate folder"
if [ -d XRay-obfuscate ]; then
  echo "Remove XRay-obfuscate folder"
  rm -rf XRay-obfuscate
else
  echo "XRay-obfuscate not found"
fi


echo "Clone repo" \
&& git clone https://github.com/ProkopMax/XRay-obfuscate.git

echo "Build image" \
&& cd XRay-obfuscate \
&& docker compose build --no-cache

echo "***Generate keys and ids in file***"
echo "**Generate uuid**" \
&& echo "uuid: $(docker run -it --rm xray-obfuscate-proxy uuid)" > $PWD/ids

echo "**Generate keys**" \
&& docker run -it --rm xray-obfuscate-proxy x25519 >> $PWD/ids

echo "**Generate short ID**" \
&& echo "shortID: $(openssl rand -hex 8)" >> $PWD/ids

echo "!!!Check the config.json file!!!"
if [ ! -s config.json ] || [ ! -f config.json ]; then
  echo "ERROR: CONFIG.JSON is empty or not found. Chek this!" && exit 1
fi

echo "**Add ID's to the config.json file**"

jq  --arg variable1 $(grep -e 'uuid:' ids | awk '{print $2}') --arg variable2 $(grep -e 'Private key:' ids | awk '{print $3}') --arg variable3 $(grep -e 'shortID:' ids | awk '{print $2}') \
  '.inbounds[].settings.clients[].id=$variable1 | .inbounds[].streamSettings.realitySettings.privateKey=$variable2 | .inbounds[].streamSettings.realitySettings.shortIds[0]=$variable3' \
  config.json > temp.json && cat temp.json | sed 's/\\r//g' > config.json

if [ -f temp.json ]; then
  rm -f temp.json
fi

echo "!!!Check updated config.json file!!!"
if [ ! -s config.json ] || [ ! -f config.json ]; then
  echo "ERROR: CONF.JSON is empty or not found. Chek this!" && exit 1
fi

echo "!!!Run XRAY server!!!"

docker compose up -d;
sleep 3;

if [[ $(docker ps | grep xray-obfuscate-proxy | grep Up | wc -l) == 1 ]]; then
  echo "****!!!XRAY server running!!!****"
  echo "**Save genarated keys and ids**"
  cat $PWD/ids
else
  echo "ERROR: Server don't start! Check logs!"
  docker logs xray-obfuscate-proxy-1 && exit 1
fi
