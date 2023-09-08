data "local_file" "defaults" {
  filename = "${path.root}/config/_defaults.yml"
}

data "local_file" "config" {
  filename = "${path.root}/config/${local.environment}.yml"
}

locals {

  test_zip_checksum        = filebase64sha256(data.archive_file.functionapp_archive.output_path)
  current_date             = formatdate("YYYY-MM-DD_HH-mm-ss", timestamp())
  identity                 = var.enable_managed_identity == true ? { dummy_create = true } : {}
  enable_application_stack = var.enable_application_stack == true ? { dummy_create = true } : {}

  environment = terraform.workspace
  config = merge(
    yamldecode(data.local_file.defaults.content),
    yamldecode(data.local_file.config.content)
  )

  dns_zone_name         = "datanow.iasp.tgscloud.net"
  private_dns_zone_name = "datanow.private.iasp.tgscloud.net"

  # Globals
  region = "France Central"
  tags = {
    "AppName"     = "AS-DATANOW-${local.environment}"
    "ManagedBy"   = "Terraform"
    "Environment" = "NonProduction"
  }
}
