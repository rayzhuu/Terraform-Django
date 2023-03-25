dependency "ecs" {
  config_path = "../ECS"
}

inputs = {
  autoscaling_group_name = dependency.ecs.outputs.autoscaling_group_name
  AutoScalingGroupName = dependency.ecs.outputs.AutoScalingGroupName
}