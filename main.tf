resource "alicloud_key_pair" "key_pair" {
  count             = var.create == true ? 1 : 0
  key_name          = var.key_name
  public_key        = var.public_key
  key_file          = var.key_file
  resource_group_id = var.resource_group_id
  tags              = var.tags
}

resource "alicloud_key_pair_attachment" "key_pair" {
  count        = var.attach == true ? 1 : 0
  instance_ids = var.instance_ids
  key_name     = concat(alicloud_key_pair.key_pair.*.key_name, [""])[0]
  force        = var.force
}

