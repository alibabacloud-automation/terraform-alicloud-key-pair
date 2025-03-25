resource "alicloud_ecs_key_pair" "key_pair" {
  count = var.create ? 1 : 0

  key_pair_name     = var.key_name
  public_key        = var.public_key
  key_file          = var.key_file
  resource_group_id = var.resource_group_id
  tags              = var.tags
}

resource "alicloud_ecs_key_pair_attachment" "key_pair" {
  count = var.attach ? 1 : 0

  instance_ids  = var.instance_ids
  key_pair_name = var.key_name != "" ? var.key_name : concat(alicloud_ecs_key_pair.key_pair[*].key_name, [""])[0]
  force         = var.force
}