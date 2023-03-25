dependency "vpc" {
  config_path = "../Network"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}