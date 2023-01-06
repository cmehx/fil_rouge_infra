variable "environments" {
  description = "Env to deploy"
  type        = list(string)
  default = [
    "dev",
    "uat"
  ]
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
  default = "Standard"
}

variable "KeyVaultName" {
  type    = string
  default = "fil_rouge_key"
}

variable "KeyVaultSKU" {
  type    = string
  default = "Standard"
}
