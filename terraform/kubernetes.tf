resource "kubernetes_cluster_role_v1" "backstage_cluster_role" {
  metadata {
    name = "backstage-cluster-role"
  }
  rule {
    verbs = ["get", "list", "watch"]
    api_groups = ["*"]
    resources = [
      "pods", "pods/log", "configmaps", "services", "deployments", "replicasets",
      "horizontalpodautoscalers",
      "ingresses", "statefulsets", "limitranges", "resourcequotas", "daemonsets"
    ]
  }
  rule {
    verbs = ["get", "list", "watch"]
    api_groups = ["batch"]
    resources = [
      "jobs", "cronjobs"
    ]
  }
  rule {
    verbs = ["get", "list"]
    api_groups = ["metrics.k8s.io"]
    resources = [
      "pods"
    ]
  }
}

resource "kubernetes_cluster_role_binding_v1" "backstage_cluster_role_binding" {
  metadata {
    name = "backstage-cluster-role"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "backstage-cluster-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "default"
  }
}

resource "kubernetes_secret_v1" "default_service_account_token" {
  metadata {
    name = "default-service-account-token"
    annotations = {
      "kubernetes.io/service-account.name" = "default"
    }
  }
  type = "kubernetes.io/service-account-token"
}
