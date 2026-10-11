resource "google_billing_budget" "billing_budgets" {
  for_each = var.billing_budgets

  billing_account = each.value.billing_account
  deletion_policy = each.value.deletion_policy
  display_name    = each.value.display_name
  ownership_scope = each.value.ownership_scope

  amount {
    last_period_amount = each.value.amount.last_period_amount
    dynamic "specified_amount" {
      for_each = each.value.amount.specified_amount != null ? [each.value.amount.specified_amount] : []
      content {
        currency_code = specified_amount.value.currency_code
        nanos         = specified_amount.value.nanos
        units         = specified_amount.value.units
      }
    }
  }

  dynamic "all_updates_rule" {
    for_each = each.value.all_updates_rule != null ? [each.value.all_updates_rule] : []
    content {
      disable_default_iam_recipients   = all_updates_rule.value.disable_default_iam_recipients
      enable_project_level_recipients  = all_updates_rule.value.enable_project_level_recipients
      monitoring_notification_channels = all_updates_rule.value.monitoring_notification_channels
      pubsub_topic                     = all_updates_rule.value.pubsub_topic
      schema_version                   = all_updates_rule.value.schema_version
    }
  }

  dynamic "budget_filter" {
    for_each = each.value.budget_filter != null ? [each.value.budget_filter] : []
    content {
      calendar_period        = budget_filter.value.calendar_period
      credit_types           = budget_filter.value.credit_types
      credit_types_treatment = budget_filter.value.credit_types_treatment
      dynamic "custom_period" {
        for_each = budget_filter.value.custom_period != null ? [budget_filter.value.custom_period] : []
        content {
          dynamic "end_date" {
            for_each = custom_period.value.end_date != null ? [custom_period.value.end_date] : []
            content {
              day   = end_date.value.day
              month = end_date.value.month
              year  = end_date.value.year
            }
          }
          start_date {
            day   = custom_period.value.start_date.day
            month = custom_period.value.start_date.month
            year  = custom_period.value.start_date.year
          }
        }
      }
      labels             = budget_filter.value.labels
      projects           = budget_filter.value.projects
      resource_ancestors = budget_filter.value.resource_ancestors
      services           = budget_filter.value.services
      subaccounts        = budget_filter.value.subaccounts
    }
  }

  dynamic "threshold_rules" {
    for_each = each.value.threshold_rules != null ? each.value.threshold_rules : []
    content {
      spend_basis       = threshold_rules.value.spend_basis
      threshold_percent = threshold_rules.value.threshold_percent
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

