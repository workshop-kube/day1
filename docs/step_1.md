# Настройка Terraform для работы с Yandex Cloud

#### Настраиваем зеркала
```bash
☁  mv ~/.terraformrc ~/.terraformrc.old
☁  nano ~/.terraformrc
```

Добавляем блок
```tf
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}

```

Реинициализируем профиль yc
```bash
cd sa_keys
yc init
# Прописываем токен, выбираем папку в yandex cloud, указываем Compute zone ru-central1-a
```


Создаем сервисный аккаунт в yandex cloud с ролью admin

```bash
☁ sudo apt install -y jq
☁ FOLDER_NAME=demo1
☁ FOLDER_ID=$(yc config get folder-id)
☁ echo $FOLDER_ID
☁ CLOUD_ID=$(yc config get cloud-id)
☁ echo $CLOUD_ID

☁ SA_NAME=terraform-admin-sa-$FOLDER_ID
☁ echo $SA_NAME

☁ yc iam service-account create --name $SA_NAME

☁ SA_ID=$(yc iam service-account get --name $SA_NAME --format json | jq .id -r)
☁ echo $SA_ID


☁ yc resource-manager folder add-access-binding --id $FOLDER_ID \
--role admin \
--subject serviceAccount:$SA_ID
```

Создаем авторизованный ключ для сервисного аккаунта и запишем его в файл.

```bash
☁ yc iam key create \
--service-account-id $SA_ID \
--folder-name $FOLDER_NAME \
--output "${SA_NAME}-key.json"
```

Где:

`service-account-id` — идентификатор сервисного аккаунта.  
`folder-name` — имя каталога, в котором создан сервисный аккаунт.  
`output` — имя файла с авторизованным ключом.


Создаем профиль CLI для выполнения операций от имени сервисного аккаунта. Укажите имя профиля:

```bash
☁ yc config profile create sa-demo-terraform
```
Результат:

```bash
Profile 'sa-demo-terraform' created and activated
```

Проверяем:
```bash
yc config profile list                                                       
default
sa-demo-terraform ACTIVE
```

Задайте конфигурацию профиля:

```bash
☁ yc config set service-account-key ${SA_NAME}-key.json
☁ yc config set cloud-id $CLOUD_ID
☁ yc config set folder-id $FOLDER_ID
```
Где:

`service-account-key` — файл с авторизованным ключом сервисного аккаунта.  
`cloud-id` — идентификатор облака.  
`folder-id` — идентификатор каталога.  
Проверить текущий конфиг профиля можно командой:
```bash
yc config list
```


Пропишем переменные окружения для terraform.
```bash
☁ export YC_TOKEN=$(yc iam create-token)
☁ export YC_CLOUD_ID=$(yc config get cloud-id)
☁ export YC_FOLDER_ID=$(yc config get folder-id)
```
Примечание. Убедитесь что активный профиль sa-demo-terraform
```bash
☁ yc config profile list
default
sa-demo-terraform ACTIVE
```
Однако, токены можно указать вручную в proviers.tf в секции `provider "yandex"`
```
provider "yandex" {
  token     = <yc_token>     # Токен для доступа к API Yandex Cloud
  cloud_id  = <yc_cloud_id>  # Идентификатор вашего облака в Yandex Cloud
  folder_id = <yc_folder_id> # Идентификатор папки, в которой будут создаваться ресурсы
  ....
}
```

Перейдем в папку с инфраструктурой и запустим terraform
```bash
cd ..
cd infra/envs/demo
terraform init
terraform validate
terraform plan
terraform apply
```



Переключимся на основной профиль yc

```bash
☁ yc config profile activate default
```

Получим авторизованный ключ для сервис аккаунта созданного через terraform

```bash
+----------------------+-----------------------------------------+
|          ID          |                  NAME                   |
+----------------------+-----------------------------------------+
| aje48miup63921nqp7qn | k8s-demo-sa                             |
| ajecqv4mb5hgll3m3dkh | terraform-admin-sa-b1g5u6eme8audu62l1l9 |
+----------------------+-----------------------------------------+
```

```bash
SA_NAME=k8s-demo-sa
SA_ID=$(yc iam service-account get --name $SA_NAME --format json | jq .id -r)
☁ yc iam key create \
--service-account-id $SA_ID \
--folder-name $FOLDER_NAME \
--output "${SA_NAME}-key.json"
```

Создадим и сконфигурируем профиль для kubectl

```bash

☁ yc config profile create sa-demo-kubectl
☁ yc config set service-account-key ${SA_NAME}-key.json
☁ yc config set cloud-id $CLOUD_ID
☁ yc config set folder-id $FOLDER_ID
```
Получим конфиги для kubectl
```bash
CLUSTER_NAME=
☁ yc managed-kubernetes cluster get-credentials k8s-demo-cluster --external

Context 'yc-k8s-demo-cluster' was added as default to kubeconfig '~/.kube/config'.
Check connection to cluster using 'kubectl cluster-info --kubeconfig ~/.kube/config'.
Note, that authentication depends on 'yc' and its config profile 'sa-demo-kubectl'.
To access clusters using the Kubernetes API, please use Kubernetes Service Account.
```

Проверить конфиг можно с помощью команды:
```bash
☁ kubectl config view
```


Создадим container registry
```
CR_NAME=yc-demo-cr
yc config profile activate default
yc container registry create --name $CR_NAME
yc container registry configure-docker # настройка docker credential helper
```
