# Use the Azure Resource Manager Provider
provider "azurerm" {
  version = "~> 2.0"
  features {}
}

# Create a new Resource Group
resource "azurerm_resource_group" "group" {
  name     = "pdtsamplecontwebapp"
  location = "westus"
}

# Create an App Service Plan with Linux
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name

  # Define Linux as Host OS
  kind = "Linux"

  # Choose size
  sku {
    tier = "Standard"
    size = "S1"
  }

  #properties = {
    reserved = true # Mandatory for Linux plans
  #}
}

# Create an Azure Web App for Containers in that App Service Plan
resource "azurerm_app_service" "webappcontapp" {
  name                = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  # Do not attach Storage by default
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false

    /*
    # Settings for private Container Registry - FYI, we won't use this as we grab a sample image from public Docker Hub
    # private registry could be Azure Container Registry - ACR   
    DOCKER_REGISTRY_SERVER_URL      = ""
    DOCKER_REGISTRY_SERVER_USERNAME = ""
    DOCKER_REGISTRY_SERVER_PASSWORD = ""
    */
  }

  # Configure Docker Image to load on start
  site_config {
    linux_fx_version = "DOCKER|microsoft/aci-helloworld:latest"
    always_on        = "true"
  }

  identity {
    type = "SystemAssigned"
  }
}