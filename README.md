# xray-automated-script
## Автоматическая установка сервера XRAY (проверено в centos, ubuntu)
https://github.com/ProkopMax/XRay-obfuscate
### 1. Скачиваем скрипты на сервер:
    curl -O https://raw.githubusercontent.com/ProkopMax/xray-automated-script/main/1-prepare.sh
    curl -O https://raw.githubusercontent.com/ProkopMax/xray-automated-script/main/2-xray.sh
### 2. Скрипт проверки/установки необходимых приложений и портов:
    sudo sh 1-prepare.sh
### 3. Скрипт запуска сервера в докер контейнере (пользователь должен состоять в группе docker):
    [[ " $(groups) " =~ ' docker '  || " $(groups) " == ' root ' ]] && sh 2-xray.sh || echo 'ERROR: Add a user to a docker group'
### 4. Сгенерированные данные находятся в папке проекта XRay-obfuscate в файде ids:
![image](https://github.com/ProkopMax/xray-automated-script/assets/72852008/77bc44fb-3731-4301-ac6f-3b38f293f9fe)
### 5. Настройка клиента:
https://github.com/ProkopMax/XRay-obfuscate/blob/main/README.md#3-client-setup
