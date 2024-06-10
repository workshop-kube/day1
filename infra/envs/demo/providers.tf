terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.117.0" # Указывайте конкретную версию для лучшей совместимости
    }
  }
}

provider "yandex" {
  zone = var.zone # Зона, в которой будут размещаться основные ресурсы
}
