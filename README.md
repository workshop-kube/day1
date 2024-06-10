
# Репозиторий Terraform для Ruby on Rails приложения в Yandex Cloud

Этот репозиторий содержит конфигурации Terraform для развертывания инфраструктуры hello-world приложения в Yandex Cloud. Инфраструктура включает Kubernetes кластер. 

## Структура репозитория

```
/yc-terraform
│
├── README.md                    # Основной файл с инструкциями
│
├── demo                      # Папка для стейджинг конфигураций
│   ├── k8s.tf                   # kubernetes кластер
│   ├── main.tf                  # Основной файл 
│   ├── outputs.tf               # Выводы terraform
│   ├── providers.tf             # Файл с провайдером yandex cloud
│   ├── terraform.tfvars         # Значения переменных
│   └── variables.tf             # Переменные 
```

## Предварительные требования

- Учетная запись в Yandex Cloud.
- Установленный Terraform (версия 0.12 или выше).
- Инициализированный `yc` CLI (Yandex Cloud CLI).

## Настройка и развертывание

### 1. Клонирование репозитория

```bash
☁ git clone https://<your-repository-url>.git
☁ cd <your-repository-directory>
```

### 2. Настройка окружения

Выберите окружение, с которым вы хотите работать:

Для demo:
```bash
☁ cd demo
```

### 3. Настройка переменных
```bash
☁ cp terraform.tfvars.example terraform.tfvars
```
Измените файл `terraform.tfvars` на основе примера и заполните его соответствующими значениями.

### 4. Настройка terraform под yandex cloud
Смотрим [Настройка Terraform для работы с Yandex Cloud](docs/terraform-yc.md)
### 5. Инициализация Terraform

```bash
☁ terraform init
```

Эта команда инициализирует Terraform, загружая нужные провайдеры.

### 6. Планирование и применение конфигурации

Отформатируйте файлы
```bash
☁ terraform fmt
```

Провалидируйте файлы
```bash
☁ terraform validate
```

Проанализируйте план развертывания:

```bash
☁ terraform plan
```

Если все выглядит корректно, примените конфигурацию:

```bash
☁ terraform apply
```

Подтвердите действие, введя `yes`, когда Terraform спросит.

## 7. Удаление инфраструктуры

Если вам нужно удалить созданную инфраструктуру, выполните:

```bash
☁ terraform destroy
```

Подтвердите действие `yes`, чтобы удалить все ресурсы.

## Примечание

Перед началом работы убедитесь, что у вас есть необходимые роли и доступы в Yandex Cloud для создания и управления ресурсами.

