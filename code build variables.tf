variable "env"{
    type = string
    default = "ecs"   
}
variable "build-project-name"{
    default = "Terraform-eb-build"
}
variable "s3-artifacts-name"{
    default = "terraform2702"
}
variable "codecommit-location"{
    default = "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/ebs"
}
variable "cloudfrontbuild-project-name"{
    default = "Terraform-cloudfront-build"
}
variable "cloudfrontcodecommit-location"{
    default = "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/cloudfront"
}
variable "ecs-build-project-name"{
    default = "Terraform-ecs-build"
}
variable "ecscodecommit-location"{
    default = "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/ecs"
}
