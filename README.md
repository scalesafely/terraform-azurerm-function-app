<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.functionapp_ai](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_linux_function_app.functionapp_lf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) | resource |
| [azurerm_resource_group.functionapp_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.functionapp_ra](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_service_plan.functionapp_sp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_storage_account.functionapp_sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules.functionapp_nr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |
| [null_resource.functionapp_checksum_rename](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [archive_file.functionapp_archive](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [local_file.config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_file.defaults](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_always_on"></a> [always\_on](#input\_always\_on) | Should the Function App be loaded at all times? | `bool` | `false` | no |
| <a name="input_app_settings_overrides"></a> [app\_settings\_overrides](#input\_app\_settings\_overrides) | n/a | `any` | `{}` | no |
| <a name="input_azurerm_service_plan_os_type"></a> [azurerm\_service\_plan\_os\_type](#input\_azurerm\_service\_plan\_os\_type) | n/a | `any` | n/a | yes |
| <a name="input_azurerm_service_plan_sku_name"></a> [azurerm\_service\_plan\_sku\_name](#input\_azurerm\_service\_plan\_sku\_name) | n/a | `any` | n/a | yes |
| <a name="input_dotnet_version"></a> [dotnet\_version](#input\_dotnet\_version) | The version of .NET to use. Possible values include 3.1 and 6 | `string` | `""` | no |
| <a name="input_enable_application_stack"></a> [enable\_application\_stack](#input\_enable\_application\_stack) | Creates application stack is set to true | `bool` | `true` | no |
| <a name="input_enable_managed_identity"></a> [enable\_managed\_identity](#input\_enable\_managed\_identity) | (optional) describe your variable | `bool` | `true` | no |
| <a name="input_ftps_state"></a> [ftps\_state](#input\_ftps\_state) | State of FTP/FTPS service for Function App | `string` | `"Disabled"` | no |
| <a name="input_function_app_enabled"></a> [function\_app\_enabled](#input\_function\_app\_enabled) | Enable or Disable FunctionApp | `bool` | `true` | no |
| <a name="input_function_app_name"></a> [function\_app\_name](#input\_function\_app\_name) | n/a | `any` | n/a | yes |
| <a name="input_function_config"></a> [function\_config](#input\_function\_config) | n/a | `any` | <pre>{<br>  "bindings": [<br>    {<br>      "authLevel": "ANONYMOUS",<br>      "direction": "in",<br>      "methods": [<br>        "get",<br>        "post"<br>      ],<br>      "name": "Request",<br>      "type": "httpTrigger"<br>    },<br>    {<br>      "direction": "out",<br>      "name": "Response",<br>      "type": "http"<br>    }<br>  ]<br>}</pre> | no |
| <a name="input_function_folder_path"></a> [function\_folder\_path](#input\_function\_folder\_path) | n/a | `string` | n/a | yes |
| <a name="input_function_language"></a> [function\_language](#input\_function\_language) | The language the Function is written in. Possible values are CSharp, Custom, Java, Javascript, Python, PowerShell, and TypeScript. | `string` | `"Python"` | no |
| <a name="input_function_sa_name"></a> [function\_sa\_name](#input\_function\_sa\_name) | Name for the function app | `string` | n/a | yes |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The path to be checked for this function app health. | `string` | `"/"` | no |
| <a name="input_identity_scope"></a> [identity\_scope](#input\_identity\_scope) | Identity scope as key and role name as value | `map(any)` | `{}` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Type of the identity | `string` | `"SystemAssigned"` | no |
| <a name="input_java_version"></a> [java\_version](#input\_java\_version) | The Version of Java to use. Supported versions include 8, and 11 | `string` | `""` | no |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | Configures the minimum version of TLS required for SSL requests | `string` | `"1.2"` | no |
| <a name="input_node_version"></a> [node\_version](#input\_node\_version) | The version of Node to run. Possible values include ~12, ~14, and ~16 | `string` | `""` | no |
| <a name="input_powershell_core_version"></a> [powershell\_core\_version](#input\_powershell\_core\_version) | The version of PowerShell Core to run. Possible values are 7, and 7.2 | `string` | `""` | no |
| <a name="input_python_version"></a> [python\_version](#input\_python\_version) | The version of Python to run. Possible values include 3.6, 3.7, 3.8, and 3.9 | `string` | `""` | no |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | n/a | `string` | `null` | no |
| <a name="input_service_plan_name"></a> [service\_plan\_name](#input\_service\_plan\_name) | n/a | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_time_zone"></a> [time\_zone](#input\_time\_zone) | time zone for the function, useful when Trigger is Timer | `string` | `"Europe/Paris"` | no |
| <a name="input_use_custom_runtime"></a> [use\_custom\_runtime](#input\_use\_custom\_runtime) | Should the Windows Function App use a custom runtime? | `bool` | `false` | no |
| <a name="input_use_dotnet_isolated_runtime"></a> [use\_dotnet\_isolated\_runtime](#input\_use\_dotnet\_isolated\_runtime) | Should the DotNet process use an isolated runtime. Defaults to false | `bool` | `false` | no |
| <a name="input_user_assigned_identity_id"></a> [user\_assigned\_identity\_id](#input\_user\_assigned\_identity\_id) | Specifies a list of user managed identity ids to be assigned.Required if Managed Identity type is UserAssigned. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_app_identity_principal_id"></a> [function\_app\_identity\_principal\_id](#output\_function\_app\_identity\_principal\_id) | n/a |
<!-- END_TF_DOCS -->
