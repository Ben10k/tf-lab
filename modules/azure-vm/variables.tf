variable "location" {
  type        = string
  default     = "West Europe"
  description = "The Azure Region where the resources should exist."
}

variable "prefix" {
  type        = string
  description = "The Name prefix which should be used for all resources."
}

variable "rg_name" {
  type        = string
  description = "The name of the rg where to store all reources."
}
