Terraform module for creating key pair on Alibaba Cloud.  
terraform-alicloud-key-pair
---------------------------------------

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-key-pair/blob/master/README-CN.md)

Terraform module which creates key pair instance on Alibaba Cloud. 

These types of resources are supported:

* [key_pair_attachment](https://www.terraform.io/docs/providers/alicloud/r/key_pair_attachment.html)
* [key_pair](https://www.terraform.io/docs/providers/alicloud/r/key_pair.html)

## Usage

```hcl
module "key_pair" {
  source   = "terraform-alicloud-modules/key-pair/alicloud"

  #key pair
  key_name = "your_public_key"
  tags = {
    Created     = "Terraform"
    Environment = "dev"
  }

  #pair_attachment
  instance_ids  =["i-bp17i59h2ixwmsxxxxxxx"]
}
```

## Examples

* [complete](https://github.com/terraform-alicloud-modules/terraform-alicloud-key-pair/tree/master/examples/complete)

## Notes
From the version v1.1.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/key-pair"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.1:

```hcl
module "key_pair" {
  source       = "terraform-alicloud-modules/key-pair/alicloud"
  version      = "1.0.1"
  region       = "cn-hangzhou"
  profile      = "Your-Profile-Name"
  key_name     = "your_public_key"
  instance_ids = ["i-bp17i59h2ixwmsxxxxxxx"]
  // ...
}
```

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
}
module "key_pair" {
  source       = "terraform-alicloud-modules/key-pair/alicloud"
  key_name     = "your_public_key"
  instance_ids = ["i-bp17i59h2ixwmsxxxxxxx"]
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  alias   = "hz"
}
module "key_pair" {
  source       = "terraform-alicloud-modules/key-pair/alicloud"
  providers    = {
    alicloud = alicloud.hz
  }
  key_name     = "your_public_key"
  instance_ids = ["i-bp17i59h2ixwmsxxxxxxx"]
  // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.66.0 |

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)