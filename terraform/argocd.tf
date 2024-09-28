resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "7.6.5"
  create_namespace = true
  values = [file("argocd/values/argocd.yaml")]
}

resource "helm_release" "argocd-apps" {
  name             = "argocd-apps"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-apps"
  namespace        = "argocd"
  version          = "2.0.1"
  create_namespace = true
  values = [file("argocd/values/argocd-apps.yaml")]
}

resource "kubernetes_config_map_v1_data" "argocd-cm" {
  metadata {
    name      = "argocd-cm"
    namespace = "argocd"
  }
  data = {
    "accounts.admin" = "apiKey"
  }
}

# data "kubernetes_secret_v1" "argocd-initial-admin-secret" {
#   metadata {
#     name      = "argocd-initial-admin-secret"
#     namespace = "argocd"
#   }
# }
#
# output "admin_password" {
#   value = data.kubernetes_secret_v1.argocd-initial-admin-secret.data.password
# }