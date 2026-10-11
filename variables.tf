variable "billing_budgets" {
  description = <<EOT
Map of billing_budgets, attributes below
Required:
    - billing_account
    - amount (block):
        - last_period_amount (optional)
        - specified_amount (optional, block):
            - currency_code (optional)
            - nanos (optional)
            - units (optional)
Optional:
    - deletion_policy
    - display_name
    - ownership_scope
    - all_updates_rule (block):
        - disable_default_iam_recipients (optional)
        - enable_project_level_recipients (optional)
        - monitoring_notification_channels (optional)
        - pubsub_topic (optional)
        - schema_version (optional)
    - budget_filter (block):
        - calendar_period (optional)
        - credit_types (optional)
        - credit_types_treatment (optional)
        - custom_period (optional, block):
            - end_date (optional, block):
                - day (required)
                - month (required)
                - year (required)
            - start_date (required, block):
                - day (required)
                - month (required)
                - year (required)
        - labels (optional)
        - projects (optional)
        - resource_ancestors (optional)
        - services (optional)
        - subaccounts (optional)
    - threshold_rules (block):
        - spend_basis (optional)
        - threshold_percent (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    billing_account = string
    deletion_policy = optional(string)
    display_name    = optional(string)
    ownership_scope = optional(string)
    amount = object({
      last_period_amount = optional(bool)
      specified_amount = optional(object({
        currency_code = optional(string)
        nanos         = optional(number)
        units         = optional(string)
      }))
    })
    all_updates_rule = optional(object({
      disable_default_iam_recipients   = optional(bool)
      enable_project_level_recipients  = optional(bool)
      monitoring_notification_channels = optional(list(string))
      pubsub_topic                     = optional(string)
      schema_version                   = optional(string)
    }))
    budget_filter = optional(object({
      calendar_period        = optional(string)
      credit_types           = optional(list(string))
      credit_types_treatment = optional(string)
      custom_period = optional(object({
        end_date = optional(object({
          day   = number
          month = number
          year  = number
        }))
        start_date = object({
          day   = number
          month = number
          year  = number
        })
      }))
      labels             = optional(map(string))
      projects           = optional(set(string))
      resource_ancestors = optional(set(string))
      services           = optional(list(string))
      subaccounts        = optional(list(string))
    }))
    threshold_rules = optional(list(object({
      spend_basis       = optional(string)
      threshold_percent = number
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.billing_budgets : (
        v.budget_filter == null || (v.budget_filter.custom_period == null || (v.budget_filter.custom_period.start_date.day >= 1 && v.budget_filter.custom_period.start_date.day <= 31))
      )
    ])
    error_message = "must be between 1 and 31"
  }
  validation {
    condition = alltrue([
      for k, v in var.billing_budgets : (
        v.budget_filter == null || (v.budget_filter.custom_period == null || (v.budget_filter.custom_period.start_date.month >= 1 && v.budget_filter.custom_period.start_date.month <= 12))
      )
    ])
    error_message = "must be between 1 and 12"
  }
  validation {
    condition = alltrue([
      for k, v in var.billing_budgets : (
        v.budget_filter == null || (v.budget_filter.custom_period == null || (v.budget_filter.custom_period.start_date.year >= 1 && v.budget_filter.custom_period.start_date.year <= 9999))
      )
    ])
    error_message = "must be between 1 and 9999"
  }
  validation {
    condition = alltrue([
      for k, v in var.billing_budgets : (
        v.budget_filter == null || (v.budget_filter.custom_period == null || (v.budget_filter.custom_period.end_date == null || (v.budget_filter.custom_period.end_date.day >= 1 && v.budget_filter.custom_period.end_date.day <= 31)))
      )
    ])
    error_message = "must be between 1 and 31"
  }
  validation {
    condition = alltrue([
      for k, v in var.billing_budgets : (
        v.budget_filter == null || (v.budget_filter.custom_period == null || (v.budget_filter.custom_period.end_date == null || (v.budget_filter.custom_period.end_date.month >= 1 && v.budget_filter.custom_period.end_date.month <= 12)))
      )
    ])
    error_message = "must be between 1 and 12"
  }
  validation {
    condition = alltrue([
      for k, v in var.billing_budgets : (
        v.budget_filter == null || (v.budget_filter.custom_period == null || (v.budget_filter.custom_period.end_date == null || (v.budget_filter.custom_period.end_date.year >= 1 && v.budget_filter.custom_period.end_date.year <= 9999)))
      )
    ])
    error_message = "must be between 1 and 9999"
  }
  # Note: 4 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

