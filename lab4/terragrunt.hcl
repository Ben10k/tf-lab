retryable_errors = [
  "(?s).*Code=\"RetryableError\".*",
  "(?s).*Error making Read request.*context deadline exceeded.*",
  "(?s).*An internal execution error occurred.*Please retry later.*",
  "(?s).*Another operation on this or dependent resource is in progress.*",
  "(?s).*Cannot proceed with operation because subnets.* are not provisioned. They are in Updating state.*",
  "(?s).*Please try again later.*",
  "(?s).*\"code\":\"CanceledAndSupersededDueToAnotherOperation\".*",
  "(?s).*Code=\"SecurityRuleConflict\".*"
]
