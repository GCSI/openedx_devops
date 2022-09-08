


# Retrieve the redis connection parameters from the shared resource namespace.
# we'll use these are the gcas environment-specific params.
data "kubernetes_secret" "redis" {
  metadata {
    name      = "redis"
    namespace = var.openedx_environment_namespace
  }
}

resource "kubernetes_secret" "secret" {
  metadata {
    name      = "redis"
    namespace = var.environment_namespace
  }

  data = {
    REDIS_HOST = data.kubernetes_secret.redis.data.REDIS_HOST
  }
}
