provider "alicloud" {
  region = "cn-zhangjiakou"
}

data "alicloud_zones" "default" {
}

data "alicloud_images" "default" {
  most_recent   = true
  instance_type = data.alicloud_instance_types.default.instance_types[0].id
}

data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones[0].id
  cpu_core_count       = 2
  memory_size          = 8
  instance_type_family = "ecs.g9i"
}

data "alicloud_resource_manager_resource_groups" "default" {
}

resource "alicloud_security_group" "default" {
  vpc_id = module.vpc.this_vpc_id
}

resource "alicloud_instance" "default" {
  security_groups      = [alicloud_security_group.default.id]
  vswitch_id           = module.vpc.this_vswitch_ids[0]
  instance_type        = data.alicloud_instance_types.default.instance_types[0].id
  image_id             = data.alicloud_images.default.images[0].id
  system_disk_category = "cloud_essd"
}

module "vpc" {
  source  = "alibaba/vpc/alicloud"
  version = "~> 1.11"

  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones[0].id]
}

#key pair
module "key_pair" {
  source = "../.."

  #key pair
  create = true

  key_name          = "key_pair_name_20220112"
  public_key        = "ssh-rsa AAAAB3Nza12345678qwertyuudsfsg"
  key_file          = "key.txt"
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups[0].id
  tags              = var.tags

  #pair_attachment
  attach = false

}

#key_pair_attachment
module "key_pair_attachment" {
  source = "../.."

  #key pair
  create = false

  #pair_attachment
  attach = true

  instance_ids = [alicloud_instance.default.id]
  key_name     = module.key_pair.this_key_name
  force        = false

}
