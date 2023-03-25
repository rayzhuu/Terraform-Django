dependency "vpc" {
  config_path = "../Network"
}
dependency "sg" {
  config_path = "../SecurityGroups"
}

inputs = {
  db_subnet_group_name    = dependency.vpc.outputs.db_subnet_group_name
  vpc_security_group_ids   = dependency.sg.outputs.vpc_security_group_ids
}

