# Cria uma novo Grupo de Recursos
resource "azurerm_resource_group" "group" {
  name     = "cont_webapp"
  location = "westus"
}