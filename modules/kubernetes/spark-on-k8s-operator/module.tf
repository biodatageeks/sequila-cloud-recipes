resource "helm_release" "spark-operator" {
  depends_on       = []
  name             = "spark-operator"
  repository       = "https://googlecloudplatform.github.io/spark-on-k8s-operator"
  chart            = "spark-operator"
  version          = "1.1.11"
  namespace        = "default"
  create_namespace = true

  set {
    name  = "serviceAccounts.spark.create"
    value = "true"
  }

  set {
    name  = "serviceAccounts.spark.name"
    value = "spark"
  }

  set {
    name  = "image.repository"
    value = "biodatageeks/spark-operator"
  }

  set {
    name  = "image.tag"
    value = "v1beta2-1.2.3-3.1.2"
  }

  set {
    name  = "image.pullPolicy"
    value = "Always"
  }

  set {
    name  = "webhook.enable"
    value = true
  }
  set {
    name  = "webhook.timeout"
    value = 30
  }
}

