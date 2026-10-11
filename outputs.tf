output "billing_budgets_id" {
  description = "Map of id values across all billing_budgets, keyed the same as var.billing_budgets except keys with no id are omitted"
  value       = { for k, v in google_billing_budget.billing_budgets : k => v.id if v.id != null && length(v.id) > 0 }
}
output "billing_budgets_all_updates_rule" {
  description = "Map of all_updates_rule values across all billing_budgets, keyed the same as var.billing_budgets except keys with no all_updates_rule are omitted"
  value       = { for k, v in google_billing_budget.billing_budgets : k => one(v.all_updates_rule) if v.all_updates_rule != null && length(v.all_updates_rule) > 0 }
}
output "billing_budgets_amount" {
  description = "Map of amount values across all billing_budgets, keyed the same as var.billing_budgets except keys with no amount are omitted"
  value       = { for k, v in google_billing_budget.billing_budgets : k => one(v.amount) if v.amount != null && length(v.amount) > 0 }
}
output "billing_budgets_billing_account" {
  description = "Map of billing_account values across all billing_budgets, keyed the same as var.billing_budgets except keys with no billing_account are omitted"
  value       = { for k, v in google_billing_budget.billing_budgets : k => v.billing_account if v.billing_account != null && length(v.billing_account) > 0 }
}
output "billing_budgets_budget_filter" {
  description = "Map of budget_filter values across all billing_budgets, keyed the same as var.billing_budgets except keys with no budget_filter are omitted"
  value       = { for k, v in google_billing_budget.billing_budgets : k => one(v.budget_filter) if v.budget_filter != null && length(v.budget_filter) > 0 }
}
output "billing_budgets_deletion_policy" {
  description = "Map of deletion_policy values across all billing_budgets, keyed the same as var.billing_budgets except keys with no deletion_policy are omitted"
  value       = { for k, v in google_billing_budget.billing_budgets : k => v.deletion_policy if v.deletion_policy != null && length(v.deletion_policy) > 0 }
}
output "billing_budgets_display_name" {
  description = "Map of display_name values across all billing_budgets, keyed the same as var.billing_budgets except keys with no display_name are omitted"
  value       = { for k, v in google_billing_budget.billing_budgets : k => v.display_name if v.display_name != null && length(v.display_name) > 0 }
}
output "billing_budgets_name" {
  description = "Map of name values across all billing_budgets, keyed the same as var.billing_budgets except keys with no name are omitted"
  value       = { for k, v in google_billing_budget.billing_budgets : k => v.name if v.name != null && length(v.name) > 0 }
}
output "billing_budgets_ownership_scope" {
  description = "Map of ownership_scope values across all billing_budgets, keyed the same as var.billing_budgets except keys with no ownership_scope are omitted"
  value       = { for k, v in google_billing_budget.billing_budgets : k => v.ownership_scope if v.ownership_scope != null && length(v.ownership_scope) > 0 }
}
output "billing_budgets_threshold_rules" {
  description = "Map of threshold_rules values across all billing_budgets, keyed the same as var.billing_budgets except keys with no threshold_rules are omitted"
  value       = { for k, v in google_billing_budget.billing_budgets : k => v.threshold_rules if v.threshold_rules != null && length(v.threshold_rules) > 0 }
}

