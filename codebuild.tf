resource "aws_codebuild_project" "terraform-eb_build" {
  badge_enabled  = false
  build_timeout  = 60
  name           = "${var.env == "eb" ? var.build-project-name : var.env == "cf" ? var.cloudfrontbuild-project-name : var.ecs-build-project-name }"
  queued_timeout = 480
  service_role   = "arn:aws:iam::928920371678:role/pipeline3in1-BuildRole-XDQBESNURPNI"

  artifacts {
    encryption_disabled    = false
    name                   = var.s3-artifacts-name
    location = var.s3-artifacts-name
    override_artifact_name = false
    packaging              = "NONE"
    type                   = "S3"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    privileged_mode             = true
    type                        = "LINUX_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }

    s3_logs {
      encryption_disabled = false
      status              = "DISABLED"
    }
  }

  source {
      type = "CODECOMMIT"
      location = "${var.env == "eb" ? var.codecommit-location : var.env == "cf" ? var.cloudfrontcodecommit-location : var.ecscodecommit-location }" 
}
}
