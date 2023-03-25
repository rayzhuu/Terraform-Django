dependency "vpc" {
  config_path = "../Network"
}

dependency "sg" {
  config_path = "../SecurityGroups"
}

dependency "CW" {
  config_path = "../CloudWatch"
}

dependency "DB" {
  config_path = "../RDS"
}

dependency "Role" {
    config_path = "../RolesPolicy
}

inputs = {
  rds_hostname = dependency.DB.outputs.rds_hostname
  security_groups = dependency.sg.outputs.security_groups
  vpc_id = dependency.vpc.outputs.vpc_id
  subnets = dependency.vpc.outputs.subnets
  iam_role = dependency.Role.outputs.iam_role
  iam_instance_profile = dependency.Role.outputs.iam_instance_profile
}