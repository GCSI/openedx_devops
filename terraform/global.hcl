#------------------------------------------------------------------------------
# written by: Lawrence McDaniel
#             https://lawrencemcdaniel.com/
#
# date: Feb-2022
#
# usage: create global parameters, exposed to all
#        Terragrunt modules in this repository.
#------------------------------------------------------------------------------
locals {
  platform_name              = "codlp"
  platform_region            = "global"
  shared_resource_identifier = "live"
  root_domain                = "global-communications-academy.com"
  services_subdomain         = "service.global-communications-academy.com"
  aws_region                 = "eu-west-2"
  account_id                 = "824885811700"

  tags = {
    "cookiecutter/platform_name"                = local.platform_name
    "cookiecutter/platform_region"              = local.platform_region
    "cookiecutter/shared_resource_identifier"   = local.shared_resource_identifier
    "cookiecutter/root_domain"                  = local.root_domain
    "cookiecutter/services_subdomain"           = local.services_subdomain
    "cookiecutter/terraform"                    = "true"
  }

}

inputs = {
  platform_name    = local.platform_name
  platform_region  = local.platform_region
  aws_region       = local.aws_region
  account_id       = local.account_id
  root_domain      = local.root_domain
}
