# resource "helm_release" "cloud_native_postgres" {
#   name             = "cloud-native-postgres"
#   repository       = "https://cloudnative-pg.github.io/charts"
#   chart            = "cloudnative-pg"
#   namespace        = "cnpg"
#   create_namespace = true
# }