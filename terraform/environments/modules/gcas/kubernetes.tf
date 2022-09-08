#------------------------------------------------------------------------------
# written by: Lawrence McDaniel
#             https://lawrencemcdaniel.com
#
# date: sep-2022
#
# usage: create an gcas application credentials and store in kubernetes secrets.
#------------------------------------------------------------------------------

data "aws_eks_cluster" "eks" {
  name = var.resource_name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.resource_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}


# Retrieve the mysql_root connection parameters from the shared resource namespace.
# we'll refer to this data for the HOST and PORT assignments on all other MySQL
# secrets.
data "kubernetes_secret" "mysql_root" {
  metadata {
    name      = "mysql-root"
    namespace = var.shared_resource_namespace
  }
}

resource "kubernetes_namespace" "gcas_namespace" {
  metadata {
    name = var.environment_namespace
  }
}

resource "random_password" "mysql_gcas" {
  length           = 16
  special          = true
  override_special = "_%@"
  keepers = {
    version = "1"

  }
}

resource "kubernetes_secret" "gcas_mysql" {
  metadata {
    name      = "mysql-gcas"
    namespace = kubernetes_namespace.gcas_namespace.id
  }

  data = {
    GCAS_MYSQL_USERNAME = "gcas"
    GCAS_MYSQL_PASSWORD = random_password.mysql_gcas.result
    MYSQL_HOST          = data.kubernetes_secret.mysql_root.data.MYSQL_HOST
    MYSQL_PORT          = data.kubernetes_secret.mysql_root.data.MYSQL_PORT
  }
}

resource "kubernetes_secret" "gcas_mysql_root" {
  metadata {
    name      = "mysql-root"
    namespace = kubernetes_namespace.gcas_namespace.id
  }

  data = {
    MYSQL_ROOT_USERNAME = data.kubernetes_secret.mysql_root.data.MYSQL_ROOT_USERNAME
    MYSQL_ROOT_PASSWORD = data.kubernetes_secret.mysql_root.data.MYSQL_ROOT_PASSWORD
    MYSQL_HOST          = data.kubernetes_secret.mysql_root.data.MYSQL_HOST
    MYSQL_PORT          = data.kubernetes_secret.mysql_root.data.MYSQL_PORT
  }
}