variable "environmentsetting"{
  type = map(object({
    namespace = string 
    name = string
    number = string
  }))
  default = {
    "Subnets" = {
      namespace = "aws:ec2:vpc"
      name      = "Subnets"
      number     = "subnet-0140c6e58b9c308a0"
    }
    "ELBSubnets" = {
      namespace = "aws:ec2:vpc"
      name      = "ELBSubnets"
      number     = "subnet-031f9b21228a2b8b0"
    }
    "ELBScheme" = {
      namespace = "aws:ec2:vpc"
      name      = "ELBScheme"
      number     = "internet facing"
    }

  }
}
variable "vpc_id"{
  default = "vpc-0bda5345aad7b49a5"
}