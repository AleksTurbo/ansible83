# Разворачиваем связку Vector+ClickHouse+lighthouse(NGINX)

## Подготовка среды:

В папке terraform находятся исходные файлы инструмента terraform.

Разворачивание среды происходит следующими этапами:
* Устанавливаем сам инструмент terraform
* Устанавливаем провайдер yandex-cloud
* Инициализируем окружение
* Разворачиваем окружение:

```bash
terraform apply
```

![YC_server](https://raw.githubusercontent.com/AleksTurbo/devops-netology/main/img/Ansible_83_YC_instans.png)

## Конфигурируем сервера посредством ANSIBLE

Подготовка серверов осуществляется инструментом ANSIBLE.  
Основной конфигурационный файл: site.yml  
Описание хостов: inventory/prod.yml
* Хосты разбиты на группы: clickhouse, vector, lighthouse
* Сервисы NGINX и lighthouse разворачиваются на одном хосте
* Переменная ansible_user: пользователь на удаленном хосте - cloud-user

## Значения переменных для хостов:  
### group_vars/all/vars.yml - общие переменные для всех хостов
* ansible_remote_user: cloud_user  

### group_vars/clickhouse/vars.yml
* clickhouse_version: "22.3.3.44" - версия устанавливаемой платформы БД
* clickhouse_database_name: logs - Имя используемой базы
* clickhouse_table_name: tbl_logs - Таблица для хранения логов
* clickhouse_packages:            - Состав компонентов платформы БД
  - clickhouse-client
  - clickhouse-server
  - clickhouse-common-static
* clickhouse_packages_cmn:
  - clickhouse-common-static
* clickhouse_host: 158.160.41.130   - IP адрес хоста с Clickhouse

### group_vars/lighthouse/vars.yml  

* nginx_user_name: nginx                                                      - служебный пользователь сервиса nginx
* lighthouse_git: https://github.com/VKCOM/lighthouse.git                     - ссылка на исходный код сервиса lighthouse
* lighthouse_access_log_name: lighthouse_access                               - имя файла лога сервиса lighthouse
* lighthouse_location_dir: /opt/lighthouse                                    - домашняя директория сервиса lighthouse

### group_vars/vector/vars.yml

* vector_version:                                                              - Версия устанавливаемого Vector
* ansible_architecture:                                                        - Архитектура устанавливаемого Vector
* vector_config_dir:                                                           - Директория расположения сервиса Vector

## Конфигурационные файлы сервисов - папка templates:

nginx.conf.j2
lighthouse.conf.j2
clickhouse.xml.j2
vector.service.j2
vector.yml.j2


## Результат успешной работы сервисов:

![YC_server]( https://raw.githubusercontent.com/AleksTurbo/devops-netology/main/img/Ansible%2083%20WEB%20lighthouse%202%20.png  )