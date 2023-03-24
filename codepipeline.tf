resource "aws_codepipeline" "Terraform-eb-pipeline" {
  name     = "${var.env == "eb" ? var.codepipeline-name : var.env == "cf" ? var.cloudfrontcodepipeline-name : var.ecscodepipeline-name }"
  role_arn = "arn:aws:iam::928920371678:role/pipeline3in1-PipelineRole-DLYKCB4G7BW9"
 
  artifact_store {
    location = "terraform2702"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      category = "Source"
      configuration = {
           RepositoryName: "${var.env == "eb" ? var.source-repository-name : var.env == "cf" ? var.cloudfrontsource-repository-name : var.ecs-repository-name}"
           BranchName: "${var.env == "eb" ? var.source-BranchName : var.env == "cf" ? var.cloudfrontsource-BranchName : var.ecssource-BranchName }"
      }
      input_artifacts = []
      name            = "Source"
      output_artifacts = [
        "SourceArtifact",
      ]
      owner     = "AWS"
      provider  = "CodeCommit"
      run_order = 1
      version   = "1"
    }
  }
  stage {
    name = "Build"

    action {
      category = "Build"
      configuration = {
        "ProjectName" = "${var.env == "eb" ? var.build-project-name : var.env == "cf" ? var.cloudfrontbuild-project-name : var.ecsbuild-project-name }"
      }
      input_artifacts = [
        "SourceArtifact",
      ]
      name = "Build"
      output_artifacts = [
        "BuildArtifact",
      ]
      owner     = "AWS"
      provider  = "CodeBuild"
      run_order = 1
      version   = "1"
    }
  }
  stage {
    name = "Deploy"

    action {
      category = "Deploy"
      configuration = {
        ApplicationName: "${var.env == "eb" ? var.eb-applicationname : null }"
        EnvironmentName: "${var.env == "eb" ? var.eb-environmentname : null }"
        BucketName: "${var.env == "cloudfront" ? "my-terraform-cf" : null }"
        Extract: "${var.env == "cloudfront" ? true : null }"
        ClusterName = "${var.env == "ecs" ? "Terraform-bharath" : null }"
        ServiceName = "${var.env == "ecs" ? "Terraform-bharath" : null }"
        FileName = "${var.env == "ecs" ? "imagedefinitions.json" : null }"
      }
      input_artifacts = [
        "BuildArtifact",
      ]
      name             = "Deploy"
      output_artifacts = []
      owner            = "AWS"
      provider         = "${var.env == "eb" ? var.deploy-provider  : var.env == "cf" ? var.cloudfrontdeploy-provider : var.ecs-provider }"
      run_order        = 1
      version          = "1"
    }
  }
}