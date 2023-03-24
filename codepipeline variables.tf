variable "env"{
    type = string
    default = "ecs"     
}
variable "codepipeline-name"{
    default = "Terraform-eb-pipeline"
}
variable "source-repository-name"{
    default = "ebs"
}
variable "source-BranchName"{
    default = "master"
}
variable "build-project-name"{
    default = "Terraform-eb-build"
}
variable "eb-applicationname"{
    default = "ebscodepipeline"
}
variable "eb-environmentname"{
    default = "Ebscodepipeline-env"
}
variable "deploy-provider"{
    default = "ElasticBeanstalk"
}
variable "cloudfrontsource-repository-name"{
    default = "cloudfront"
}
variable "cloudfrontsource-BranchName"{
    default = "master"
}
variable "cloudfrontbuild-project-name"{
    default = "Terraform-cloudfront-build"
}
variable "cloudfrontdeploy-provider"{
    default = "S3"
}
variable "cloudfrontcodepipeline-name"{
    default = "Terraform-cloudfront-pipeline"
}
variable "ecscodepipeline-name"{
    default = "Terraform-ecs-pipeline"
}
variable "ecs-repository-name"{
    default = "ecs"
}
variable "ecssource-BranchName"{
    default = "master"
}
variable "ecsbuild-project-name"{
    default = "build"
}
variable "ecs-provider"{
    default = "ecs"
}