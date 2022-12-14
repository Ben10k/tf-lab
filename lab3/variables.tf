variable "location" {
  type        = string
  default     = "West Europe"
  description = "The Azure Region where the resources should exist."
}

variable "prefix" {
  type        = string
  description = "The Name prefix which should be used for all resources"
}

variable "vm_count" {
  default     = 1
  description = "Number of VMs to create"
}
