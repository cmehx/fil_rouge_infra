variable "environment" {
  description = "Env to deploy"
  type        = string
  default = "dev"
}

variable "Location" {
  type    = string
  default = "EastUs"
}

variable "ResourceGroup" {
  type    = string
  default = "fil_rouge_grp"
}

variable "ContainerRegistryName" {
  type    = string
  default = "FilRougeRegistry"
}

variable "ContainerRegistrySKU" {
  type    = string
  default = "Premium"
}

variable "KeyVaultName" {
  type    = string
  default = "FilRougeKey"
}

variable "KeyVaultSKU" {
  type    = string
  default = "standard"
}

variable "ClusterName" {
  type    = string
  default = "fil_rouge_cluster"
}

variable "appId" {
  type    = string
  default = "fil_rouge_app"
}
variable "password" {
  type    = string
  default = "fil_rouge_pwd"
}