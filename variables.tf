

#key pair
variable "create" {
  description = "Whether to create key pair. Default to true."
  type        = bool
  default     = true
}

variable "key_name" {
  description = "The key pair's name. It is the only in one Alicloud account."
  type        = string
  default     = ""
}

variable "public_key" {
  description = "You can import an existing public key and using Alicloud key pair to manage it."
  type        = string
  default     = ""
}

variable "key_file" {
  description = "The name of file to save your new key pair's private key. Strongly suggest you to specified it when you creating key pair, otherwise, you wouldn't get its private key ever."
  type        = string
  default     = ""
}

variable "resource_group_id" {
  description = "The Id of resource group which the key pair belongs."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}

#key pair attachment
variable "attach" {
  description = "Whether to create key pair attachment. Default to true."
  type        = bool
  default     = true
}

variable "instance_ids" {
  description = "The list of ECS instance's IDs."
  type        = list(string)
  default     = []
}

variable "force" {
  description = "Set it to true and it will reboot instances which attached with the key pair to make key pair affect immediately."
  type        = bool
  default     = true
}