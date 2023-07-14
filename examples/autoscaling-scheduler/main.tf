# Terraform autoscaling group with lambda scheduler

### Terraform modules ###

module "autoscaling-stop-friday" {
  source                         = "../../"
  name                           = "stop-autoscaling"
  cloudwatch_schedule_expression = "cron(24 11 ? * MON-SUN *)" # UTC
  schedule_action                = "stop"
  ec2_schedule                   = "false"
  rds_schedule                   = "false"
  autoscaling_schedule           = "true"
  cloudwatch_alarm_schedule      = "false"

  scheduler_tag = {
    key   = "eks:cluster-name"
    value = "lasv2-vault-cluster-prod"
  }
}

module "autoscaling-start-monday" {
  source                         = "../../"
  name                           = "start-autoscaling"
  cloudwatch_schedule_expression = "cron(34 11 ? * MON-SUN *)" # UTC
  schedule_action                = "start"
  ec2_schedule                   = "false"
  rds_schedule                   = "false"
  autoscaling_schedule           = "true"
  cloudwatch_alarm_schedule      = "false"

  scheduler_tag = {
    key   = "eks:cluster-name"
    value = "lasv2-vault-cluster-prod"
  }
}
