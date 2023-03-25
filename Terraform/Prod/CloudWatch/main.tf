resource "aws_cloudwatch_log_group" "django-log-group" {
  name              = "/ecs/django-app"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "django-log-stream" {
  name           = "django-app-log-stream"
  log_group_name = aws_cloudwatch_log_group.django-log-group.name
}

resource "aws_cloudwatch_log_group" "nginx-log-group" {
  name              = "/ecs/nginx"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "nginx-log-stream" {
  name           = "nginx-log-stream"
  log_group_name = aws_cloudwatch_log_group.nginx-log-group.name
}


resource "aws_autoscaling_policy" "alarm-policy" {
  name                   = "too many request policy"
  scaling_adjustment     = var.policy_scaled
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ecs-cluster.name
}

resource "aws_cloudwatch_metric_alarm" "request-alarm" {
  alarm_name          = "Too many request"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "RequestCount"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ecs-cluster.name
  }

  alarm_description = "This metric monitors ecs request count"
  alarm_actions     = [aws_autoscaling_policy.alarm-policy.arn]
}
