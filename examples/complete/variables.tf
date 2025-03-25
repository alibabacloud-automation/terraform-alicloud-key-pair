#key pair
variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(any)
  default = {
    Name = "KEY-PAIR"
  }
}