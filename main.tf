# Provedor Terraform Azure
provider "azurerm" {
  version = "~> 2.0"
  features {}
}

# Criar no Azure Web App um containers com o App Service
resource "azurerm_app_service" "webapp" {
  name                = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  # Não attach Armazanamento padrão
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false

  }

  # Configurar docker imagem para carregar e iniciar o serviço
  site_config {
    linux_fx_version = "DOCKER|pdetender/simplcommerce:latest" # Imagem de um projeto da internet para teste
    always_on        = "true"
  }

  identity {
    type = "SystemAssigned"
  }
}