variable "app_settings_overrides" {
  type    = any
  default = {}
}

variable "service_plan_name" {}

variable "function_app_name" {}

variable "azurerm_service_plan_os_type" {
}

variable "azurerm_service_plan_sku_name" {
}

variable "subnet_id" {
}

variable "function_sa_name" {
  description = "Name for the function app"
  type        = string

  validation {
    condition     = can(regex("^([a-z0-9]){3,24}$", var.function_sa_name))
    error_message = "The function app name must be between 3 and 24 characters long and contain only lowercase letters and numbers."
  }
}

variable "storage_account_default_action" {
  type        = string
  default     = "Deny"
  description = "Default Action for accessing storage account"
}

variable "enable_application_stack" {
  type        = bool
  description = "Creates application stack is set to true"
  default     = true
}

variable "function_language" {
  type        = string
  description = "The language the Function is written in. Possible values are CSharp, Custom, Java, Javascript, Python, PowerShell, and TypeScript."
  default     = "Python"
}

variable "function_config" {
  type = any
  default = {
    "bindings" : [
      {
        "authLevel" : "ANONYMOUS",
        "type" : "httpTrigger",
        "direction" : "in",
        "name" : "Request",
        "methods" : [
          "get",
          "post"
        ]
      },
      {
        "type" : "http",
        "direction" : "out",
        "name" : "Response"
      }
    ]
  }
}

variable "identity_scope" {
  type        = map(any)
  description = "Identity scope as key and role name as value"
  default     = {}
}

variable "function_folder_path" {
  type = string
}

variable "enable_managed_identity" {
  type        = bool
  description = "(optional) describe your variable"
  default     = true
}

variable "identity_type" {
  type        = string
  description = "Type of the identity"
  default     = "SystemAssigned"
}

variable "function_app_enabled" {
  type        = bool
  description = "Enable or Disable FunctionApp"
  default     = true
}

variable "always_on" {
  type        = bool
  description = "Should the Function App be loaded at all times?"
  default     = false
}

variable "time_zone" {
  type        = string
  description = "time zone for the function, useful when Trigger is Timer"
  default     = "Europe/Paris"
}

variable "user_assigned_identity_id" {
  type        = list(string)
  description = "Specifies a list of user managed identity ids to be assigned.Required if Managed Identity type is UserAssigned."
  default     = []
}

variable "minimum_tls_version" {
  type        = string
  description = "Configures the minimum version of TLS required for SSL requests"
  default     = "1.2"
}

variable "ftps_state" {
  type        = string
  description = "State of FTP/FTPS service for Function App"
  default     = "Disabled"
}

variable "dotnet_version" {
  type        = string
  description = "The version of .NET to use. Possible values include 3.1 and 6"
  default     = ""
}

variable "use_dotnet_isolated_runtime" {
  type        = bool
  description = "Should the DotNet process use an isolated runtime. Defaults to false"
  default     = false
}

variable "java_version" {
  type        = string
  description = "The Version of Java to use. Supported versions include 8, and 11"
  default     = ""
}

variable "node_version" {
  type        = string
  description = "The version of Node to run. Possible values include ~12, ~14, and ~16"
  default     = ""
}

variable "powershell_core_version" {
  type        = string
  description = "The version of PowerShell Core to run. Possible values are 7, and 7.2"
  default     = ""
}

variable "use_custom_runtime" {
  type        = bool
  description = "Should the Windows Function App use a custom runtime?"
  default     = false
}

variable "python_version" {
  type        = string
  description = "The version of Python to run. Possible values include 3.6, 3.7, 3.8, and 3.9"
  default     = ""
}

variable "health_check_path" {
  type        = string
  description = "The path to be checked for this function app health."
  default     = "/"
}

variable "service_plan_id" {
  type    = string
  default = null
}
