# Networking Variables
variable "public_subnet_1_cidr" {
  description = "CIDR BLOCK FOR PUB SUBNET 1"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR BLOCK FOR PUB SUBNET 2"
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR BLOCK FOR PRI SUBNET 1"
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR BLOCK FOR PRI SUBNET 2"
  default     = "10.0.4.0/24"
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1b", "us-east-1c"]
}
