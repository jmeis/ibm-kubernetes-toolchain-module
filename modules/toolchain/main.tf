terraform {
  required_version = ">= 0.13"
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = ">= 1.17.0"
    }
  }
}

# Fetch IAM token for user
data "ibm_iam_auth_token" "tokendata" {}

# Fetch resource group
data "ibm_resource_group" "group" {
  name = var.resource_group
  is_default = var.resource_group == null ? true : null
}

resource "null_resource" "toolchain" {
  # This will cause toolchain to be created every time
  # instead of needing to run `terraform destroy` first
  triggers = {
    timestampe = timestamp()
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/create-toolchain.sh"

    environment={
      # Tip on how to reduce object into parameters string:
      # https://stackoverflow.com/a/60301168
      ADDITIONAL_PARAMETERS = join("&", formatlist("%s=%s", keys(var.additional_parameters), values(var.additional_parameters)))
      API_KEY = var.api_key
      BRANCH = var.template_branch
      IAM_TOKEN = data.ibm_iam_auth_token.tokendata.iam_access_token

      # TODO default region to TF_VAR_SCHEMATICSLOCATION env var
      REGION = var.region
      REPOSITORY = var.template_repo
      RESOURCE_GROUP_ID = data.ibm_resource_group.group.id
    }
  }
}
