# variable "yc_token" {
#   description = "Токен для API Yandex Cloud"
#   type        = string
# }

# variable "yc_cloud_id" {
#   description = "Идентификатор облака в Yandex Cloud"
#   type        = string
# }

variable "yc_folder_id" {
  description = "Идентификатор папки в Yandex Cloud"
  type        = string
}

variable "zone" {
  description = "Зона для размещения ресурсов, например 'ru-central1-a'"
  type        = string
  default     = "ru-central1-a"
}

# variable "network_id" {
#   description = "Идентификатор сети в Yandex Cloud, где будут создаваться ресурсы"
#   type        = string
# }

# variable "subnet_id" {
#   description = "Идентификатор сети в Yandex Cloud, где будут создаваться ресурсы"
#   type        = string
# }

# variable "service_account_id" {
#   description = "Идентификатор сервис аккаунта"
#   type        = string
# }

# variable "node_service_account_id" {
#   description = "Идентификатор сервис аккаунта для узлов"
#   type        = string
# }


