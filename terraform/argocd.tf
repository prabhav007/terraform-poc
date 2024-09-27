resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "7.6.5"
  create_namespace = true
  values           = [file("argocd/values/argocd.yaml")]
}

resource "helm_release" "argocd-apps" {
  name             = "argocd-apps"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-apps"
  namespace        = "argocd"
  version          = "2.0.1"
  create_namespace = true
  values           = [file("argocd/values/argocd-apps.yaml")]
}