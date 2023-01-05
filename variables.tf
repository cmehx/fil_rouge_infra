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
    default     = "fil_rouge_grp_dev"   
}

variable "ContainerRegistryName" {
    type        = string
    default     = "filRougeRegistryDev"
}

variable "ContainerRegistrySKU" {
    type        = string
    default     = "Standard"
}