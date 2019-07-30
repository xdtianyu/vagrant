#!/bin/bash

source /tmp/.env

if [ ! -z "$PROXY_HOST" ]; then
    echo "systemProp.http.proxyHost=$PROXY_HOST
systemProp.http.proxyPort=$PROXY_PORT
systemProp.http.nonProxyHosts=$NO_PROXY_HOST
systemProp.https.proxyHost=$PROXY_HOST
systemProp.https.proxyPort=$PROXY_PORT
systemProp.https.nonProxyHosts=$NO_PROXY_HOST" > /opt/cache/gradle/gradle.properties
else
    echo "" > /opt/cache/gradle/gradle.properties
fi

if [ ! -z "$(cat /etc/gitlab-runner/config.toml |grep url\ =\ \"$URL\")" ]; then
    echo "Runner is already registered."
    exit 0
fi

sudo gitlab-runner register \
  --non-interactive \
  --url "$URL" \
  --registration-token "$TOKEN" \
  --executor "docker" \
  --docker-image openjdk:8-jdk \
  --description "$(hostname)" \
  --tag-list "docker,runner" \
  --run-untagged="true" \
  --locked="false" \
  --docker-privileged \
  --env "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/sdk/emulator/:/opt/sdk/tools/bin:/opt/sdk/tools:/opt/sdk/platform-tools:/opt/ndk:/opt/sdk/cmake/3.10.2.4988404/bin" \
  --env "ANDROID_HOME=/opt/sdk" \
  --env "ANDROID_SDK=/opt/sdk" \
  --env "ANDROID_NDK=/opt/ndk" \
  --env "ANDROID_NDK_HOME=/opt/ndk" \
  --env "GRADLE_USER_HOME=/opt/cache/gradle" \
  --docker-volumes "/opt/ndk:/opt/ndk:rw" \
  --docker-volumes "/opt/sdk:/opt/sdk:rw" \
  --docker-volumes "/opt/cache/gradle:/opt/cache/gradle:rw" \
  --docker-volumes "/dev/kvm:/dev/kvm:rw" \
  --docker-network-mode "host" \
  --docker-extra-hosts "" \
  --access-level="not_protected"

