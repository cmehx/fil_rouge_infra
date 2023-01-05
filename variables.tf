variable "environments" {
  description = "Env to deploy"
  type        = list(string)
  default = [
    "dev",
    "uat",
    "prod"
  ]
}

variable "Location" {
    type        = string
    default     = "EastUs"
}

variable "ResourceGroup" {
    type        = string
    default     = "fil_rouge_grp"
}

variable "ContainerRegistryName" {
    type        = string
    default     = "filRougeRegistry"
}

variable "ContainerRegistrySKU" {
    type        = string
    default     = "Standard"
}