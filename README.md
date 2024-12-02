## HOWTO

Get the unreleased provider code that allows you to create a project-owned varset:

```
git clone https://github.com/hashicorp/terraform-provider-tfe
cd terraform-provider-tfe
git checkout mkam/TF-20798/project-owned-varsets
eval $(make devoverride)
```

Set `TFE_ORGANIZATION` to an existing org, for example:

```
export TFE_ORGANIZATION=my-organization
```

In `main.tf`, change the prefix to a random string.

```
locals {
  prefix = "iasudhf"
}
```

Run:

```
terraform init
terraform apply
```
