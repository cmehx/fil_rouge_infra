ressource "random_string" "random_env" {
    length = 3
    numeric = false
    special = false
    upper = false
}

variable "environments" {
  description = "Env to deploy"
  type        = list(string)
  default = [random_string.random_env.result]
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
    default     = "FilRougeRegistry"
}

variable "ContainerRegistrySKU" {
    type        = string
    default     = "Standard"
}