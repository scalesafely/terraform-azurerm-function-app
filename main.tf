resource "azurerm_resource_group" "functionapp_rg" {
  name     = var.function_app_name
  location = local.region
  tags     = local.tags
}

resource "azurerm_storage_account" "functionapp_sa" {
  name                            = var.function_sa_name
  resource_group_name             = azurerm_resource_group.functionapp_rg.name
  location                        = azurerm_resource_group.functionapp_rg.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  tags                            = local.tags
}

resource "azurerm_storage_account_network_rules" "functionapp_nr" {
  storage_account_id         = azurerm_storage_account.functionapp_sa.id
  default_action             = var.storage_account_default_action
  virtual_network_subnet_ids = [var.subnet_id]
  bypass                     = ["Metrics", "Logging", "AzureServices"]
}

resource "azurerm_service_plan" "functionapp_sp" {
  name                = var.service_plan_name
  location            = azurerm_resource_group.functionapp_rg.location
  os_type             = var.azurerm_service_plan_os_type
  resource_group_name = azurerm_resource_group.functionapp_rg.name
  sku_name            = var.azurerm_service_plan_sku_name
  tags                = local.tags
}

resource "azurerm_linux_function_app" "functionapp_lf" {
  name                       = var.function_app_name
  location                   = azurerm_resource_group.functionapp_rg.location
  resource_group_name        = azurerm_resource_group.functionapp_rg.name
  service_plan_id            = var.service_plan_id != null ? var.service_plan_id : azurerm_service_plan.functionapp_sp.id
  enabled                    = var.function_app_enabled
  zip_deploy_file            = "${var.function_folder_path}/../${data.archive_file.functionapp_archive.output_md5}.zip"
  https_only                 = true
  storage_account_name       = azurerm_storage_account.functionapp_sa.name
  storage_account_access_key = azurerm_storage_account.functionapp_sa.primary_access_key
  virtual_network_subnet_id  = var.subnet_id
  app_settings = merge(
    {
      WEBSITE_RUN_FROM_PACKAGE = 1
      WEBSITE_TIME_ZONE        = var.time_zone
      ZIP_CHECKSUM             = local.test_zip_checksum
    },
    var.app_settings_overrides
  )
  tags = local.tags
  dynamic "identity" {
    for_each = local.identity
    content {
      type         = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned" ? var.user_assigned_identity_id : null
    }
  }
  site_config {
    ftps_state                             = var.ftps_state
    minimum_tls_version                    = var.minimum_tls_version
    application_insights_connection_string = azurerm_application_insights.functionapp_ai.connection_string
    application_insights_key               = azurerm_application_insights.functionapp_ai.instrumentation_key
    always_on                              = var.always_on
    health_check_path                      = var.health_check_path
    app_service_logs {
      disk_quota_mb         = 35
      retention_period_days = 7
    }
    cors {
      allowed_origins = ["https://portal.azure.com"]
    }

    dynamic "application_stack" {
      for_each = local.enable_application_stack
      content {
        dotnet_version              = var.dotnet_version
        use_dotnet_isolated_runtime = var.use_dotnet_isolated_runtime
        java_version                = var.java_version
        node_version                = var.node_version
        powershell_core_version     = var.powershell_core_version
        use_custom_runtime          = var.use_custom_runtime
        python_version              = var.python_version
      }
    }
  }
  lifecycle {
    ignore_changes = [
      site_config[0].vnet_route_all_enabled,
    ]
  }
}

data "archive_file" "functionapp_archive" {
  type        = "zip"
  source_dir  = var.function_folder_path
  output_path = "${var.function_folder_path}/../${var.function_sa_name}.tmp.zip"
}

resource "null_resource" "functionapp_checksum_rename" {
  triggers = {
    md5 = data.archive_file.functionapp_archive.output_md5
  }

  provisioner "local-exec" {
    command = "mv ${data.archive_file.functionapp_archive.output_path} ${var.function_folder_path}/../${data.archive_file.functionapp_archive.output_md5}.zip"
  }
}

resource "azurerm_application_insights" "functionapp_ai" {
  name                = "${var.function_sa_name}-appinsights"
  location            = azurerm_resource_group.functionapp_rg.location
  resource_group_name = azurerm_resource_group.functionapp_rg.name
  application_type    = "web"
  tags                = local.tags
}

resource "azurerm_role_assignment" "functionapp_ra" {
  for_each             = var.identity_scope
  scope                = each.key
  role_definition_name = each.value
  principal_id         = azurerm_linux_function_app.functionapp_lf.identity[0].principal_id
}
