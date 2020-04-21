terraform {
  backend "s3" {
    region = "eu-west-2"
    bucket = "gazzerh-terraform-state"
    key    = "state/checkout-dot-com"
  }
}

provider "aws" {
  region  = var.region
  version = "~> 2.58"
}

module "networking" {
  source = "./modules/networking"

  app_name   = var.app_name
  region     = var.region
  cidr_block = var.cidr_block
  az_number  = var.az_number
}

module "ecs_cluster" {
  source = "./modules/ecs_cluster"

  app_name = var.app_name
  vpc_id   = module.networking.vpc.id
}

module "ecr" {
  source = "./modules/ecr"

  app_name = var.app_name
  vpc      = module.networking.vpc

  private_subnets = module.networking.private_subnets
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  app_name = var.app_name
  vpc      = module.networking.vpc

  cloudwatch_group_name = "/ecs/fargate/task/${var.app_name}"
  private_subnets       = module.networking.private_subnets
}

module "ecs_fargate_app" {
  source = "./modules/ecs_fargate_app"

  app_name = var.app_name
  region   = var.region
  vpc_id   = module.networking.vpc.id
  fqdn     = var.fqdn

  ecs_cluster             = module.ecs_cluster.ecs_cluster
  ecs_sg                  = module.ecs_cluster.ecs_sg
  private_subnets         = module.networking.private_subnets
  public_subnets          = module.networking.public_subnets
  ecs_task_execution_role = module.ecs_cluster.ecs_task_execution_role
  cloudwatch_log_group    = module.cloudwatch.cloudwatch_log_group

  container_definition = { // container memory and cpu dont't need to be provided in fargate deployments
    name           = "${format("%s-container", var.app_name)}"
    image          = "${module.ecr.ecr_container_image.repository_url}:${var.app_version}"
    container_port = 5000
  }
}
