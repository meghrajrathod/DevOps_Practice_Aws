locals {
  project = "windows-devops"
  env     = "dev"

  common_tags = {
    Project = local.project
    Env     = local.env
  }
}