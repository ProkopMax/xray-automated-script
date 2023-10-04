# xray-automated-script
## Автоматическая устнавка сервера XRAY
### 1. Скачиваем скрипты на сервер:
    curl -O https://raw.githubusercontent.com/ProkopMax/xray-automated-script/main/1-prepare.sh
    curl -O https://raw.githubusercontent.com/ProkopMax/xray-automated-script/main/2-xray.sh
### 2. Скрипт проверки/установки необходимых приложений и портов:
    sudo sh 1-prepare.sh
### 3. Скрипт запуска сервера в докер контейнере (пользователь должен состоять в группе docker):
    [[ " $(groups) " =~ ' docker '  || " $(groups) " == ' root ' ]] && sh 2-xray.sh || echo 'ERROR: Add a user to a docker group'
