#!/bin/sh

echo "Check software"

echo "Check GIT"
if command -v git >/dev/null; then
  echo "GIT is used here"
else
  echo "Not found GIT"
  echo "Let's install GIT"

  if command -v yum >/dev/null; then
    echo "YUM is used here";
    yum install -y git-core;

    if command -v git >/dev/null; then
       echo "GIT instaled with yum"
    else
      echo "ERROR: Not instaled GIT" && exit 1
    fi
  elif command -v apt-get >/dev/null; then
    echo "APT is used here";
    apt-get update && apt-get install -y git-core;

    if command -v git >/dev/null; then
       echo "GIT instaled with apt-get"
    else
      echo "ERROR: Not instaled GIT" && exit 1
    fi
  else
    echo "ERROR: Not found YUM or APT" && exit 1
  fi
fi

echo "Check DOCKER!"
if command -v docker >/dev/null; then
  echo "DOCKER is used here"
else
  echo "Not found DOCKER"
  echo "Let's install DOCKER"

  if command -v yum >/dev/null; then
    echo "YUM is used here";
    yum install -y yum-utils;
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo;
    yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    systemctl enable docker && systemctl start docker;

    if command -v docker >/dev/null; then
       echo "DOCKER instaled with yum"
    else
      echo "ERROR: Not instaled DOCKER" && exit 1
    fi
  elif command -v apt-get >/dev/null; then
    echo "APT is used here";
    apt-get update && apt-get install -y install ca-certificates curl gnupg;
    install -m 0755 -d /etc/apt/keyrings;
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg;
    chmod a+r /etc/apt/keyrings/docker.gpg;
    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update;
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin;
    systemctl enable docker && systemctl start docker;
    if command -v docker >/dev/null; then
       echo "DOCKER instaled with apt-get"
    else
      echo "ERROR: Not instaled DOCKER" && exit 1
    fi
  else
    echo "ERROR: Not found YUM or APT" && exit 1
  fi
fi

echo "Check JQ"
if command -v jq >/dev/null; then
  echo "JQ is used here"
else
  echo "Not found JQ"
  echo "Let's install JQ"

  if command -v yum >/dev/null; then
    echo "YUM is used here";
    yum install -y epel-release && yum install -y jq;

    if command -v jq >/dev/null; then
       echo "JQ instaled with yum"
    else
      echo "ERROR: Not instaled JQ with yum" && exit 1
    fi
  elif command -v apt-get >/dev/null; then
    echo "APT is used here";
    apt-get update && apt-get install -y jq;

    if command -v jq >/dev/null; then
       echo "JQ instaled with apt-get"
    else
      echo "ERROR: Not instaled JQ with apt" && exit 1
    fi
  else
    echo "ERROR: Not found YUM or APT" && exit 1
  fi
fi

echo "Check 443 port"
if [ $(ss -lptnu | grep 443 | wc -l) != 0 ]; then
  echo "ERROR: 443 port is used " && exit 1
else
  echo "443 port not used"
fi
