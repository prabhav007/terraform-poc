# resource "kubernetes_namespace" "backstage" {
#   metadata {
#     name = "backstage"
#   }
# }
#
# resource "kubernetes_secret" "backstage_app_secret" {
#   metadata {
#     name      = "app-secret"
#     namespace = "backstage"
#   }
#
#   data = {
#     username = "app"
#     password = "password"
#   }
#
#   type = "kubernetes.io/basic-auth"
#
#   depends_on = [kubernetes_namespace.backstage]
# }
#
# resource "kubernetes_manifest" "openfaas_fn_showcow" {
#   manifest = {
#     "apiVersion" = "postgresql.cnpg.io/v1"
#     "kind"       = "Cluster"
#     "metadata" = {
#       "name"      = "backstage"
#       "namespace" = "backstage"
#     }
#     "spec" = {
#       "bootstrap" = {
#         "initdb" = {
#           "postInitSQL" = [
#             "ALTER ROLE app CREATEDB",
#           ]
#           "secret" = {
#             "name" = "app-secret"
#           }
#         }
#       }
#       "instances"             = 1
#       "primaryUpdateStrategy" = "unsupervised"
#       "storage" = {
#         "size" = "1Gi"
#       }
#     }
#   }
#
#   depends_on = [kubernetes_secret.backstage_app_secret, helm_release.cloud_native_postgres]
# }
#
# resource "helm_release" "backstage" {
#   name             = "backstage"
#   repository       = "https://platformerscommunity.github.io/backstage-helm-chart/"
#   chart            = "backstage"
#   namespace        = "backstage"
#   create_namespace = true
#
#   set {
#     name  = "github.accessToken"
#     value = "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3"
#   }
#   depends_on = [kubernetes_manifest.openfaas_fn_showcow]
# }