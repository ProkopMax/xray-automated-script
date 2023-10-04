# xray-automated-script
## Автоматическая установка сервера XRAY (проверено в centos, ubuntu)
https://github.com/ProkopMax/XRay-obfuscate
### Скачиваем скрипты на сервер:
    curl -O https://raw.githubusercontent.com/ProkopMax/xray-automated-script/main/1-prepare.sh
    curl -O https://raw.githubusercontent.com/ProkopMax/xray-automated-script/main/2-xray.sh
    
### 1-prepare.sh скрипт проверки/установки необходимых приложений и портов:
    sudo bash 1-prepare.sh
### 2-xray.sh скрипт запуска сервера в докер контейнере (пользователь должен состоять в группе docker):
    [[ " $(groups) " =~ ' docker '  || " $(groups) " == ' root ' ]] && bash 2-xray.sh || echo 'ERROR: Add a user to a docker group'
### Сгенерированные данные находятся в папке проекта XRay-obfuscate в файле ids:
![image](https://github.com/ProkopMax/xray-automated-script/assets/72852008/77bc44fb-3731-4301-ac6f-3b38f293f9fe)
### Настройка клиента:
https://github.com/ProkopMax/XRay-obfuscate/blob/main/README.md#3-client-setup
