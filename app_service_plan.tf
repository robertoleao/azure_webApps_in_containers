# Crie um plano de serviço de aplicativo com Linux
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name

  # Define o SO da maquina
  kind = "Linux"

  # Verão da maquina que rodara o contaner
  sku {
    tier = "Standard"
    size = "S1"
  }

  #properties = {
    reserved = true # Obrigatório para planos Linux
  #}
}