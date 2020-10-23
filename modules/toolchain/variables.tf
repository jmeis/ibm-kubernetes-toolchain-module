variable "additional_parameters" {
  type = map(string)
  description = "Additional toolchain parameters in map form"
  default = {}
}

variable "api_key" {
  type        = string
  description = "The IAM API Key for IBM Cloud access"
}

variable "region" {
  type        = string
  description = "IBM Cloud Region"
  default     = "us-south"
}

variable "resource_group" {
  type = string
  description = "Resource group name where the toolchain should be created"
  default = null
}

variable "template_branch" {
  type = string
  description = "Open Toolchain Template branch"
  default = "master"
}

variable "template_repo" {
  type        = string
  description = "Open Toolchain Template URL"
  default     = "https://github.com/open-toolchain/empty-toolchain"
}
