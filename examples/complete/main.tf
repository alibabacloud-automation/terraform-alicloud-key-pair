variable "profile" {
  default = "default"
}
variable "region" {
  default = "cn-hangzhou"
}
data "alicloud_instances" "default" {}

provider "alicloud" {
  region  = var.region
  profile = var.profile
}

module "key_pair" {
  source  = "../.."
  profile = var.profile
  region  = var.region

  #key pair
  key_name = "my_public_key_001"
  tags = {
    Created     = "Terraform"
    Environment = "dev"
  }

  #pair_attachment
  instance_ids = [data.alicloud_instances.default.ids[0]]

}

