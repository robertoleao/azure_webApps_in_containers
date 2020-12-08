# Terraform para implantar WebApps Azure em container

![Capa da materia](cover.jpg "Capa da materia")

Este projeto ajudara a implantar uma instância do Azure WebApp App Service. E ao mesmo tempo, introduz você no Azure WebApp for Containers, onde em vez de publicar o código-fonte do aplicativo, você executa um contêiner Docker .


## app_service_plan.tf

+ **azurer_app_service_plan**

    ```ruby
    resource "azurerm_app_service_plan" "appserviceplan" {
    name                = azurerm_resource_group.group.name
    location            = azurerm_resource_group.group.location
    resource_group_name = azurerm_resource_group.group.name

    kind = "Linux"

    sku {
        tier = "Standard"
        size = "S1"
    }

    #properties = {
        reserved = true 
    #}
    }
    ```

    + Este arquivo tem a finalidade de declarar todas as configurações para a criação de um plano de serviço de aplicativos Azure .

## resource_group.tf

+ **azurerm_resource_group**

    ```ruby
    resource "azurerm_resource_group" "group" {
    name     = "cont_webapp"
    location = "westus"
    }
    ```
    + Cria um grupo de recurso com nome cont_webapp na localização westus . 

## main.tf

+ **Provider**

    ```ruby
    provider "azurerm" {
    version = "~> 2.0"
    features {}
    }
    ```

    + Definer o provedor terraform Azure e qual versão especifica que voce deseja usar .

+ **azurerm_app_service**

    ```ruby
    resource "azurerm_app_service" "web_app_contapp" {
    name                = azurerm_resource_group.group.name
    location            = azurerm_resource_group.group.location
    resource_group_name = azurerm_resource_group.group.name
    app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

    app_settings = {
        WEBSITES_ENABLE_APP_SERVICE_STORAGE = false

    }
    ```

    + Esta seção contém os detalhes do serviço de aplicativos Azure em si .

+ **linux_fx_version**

    ```ruby
    site_config {
        linux_fx_version = "DOCKER|pdetender/simplcommerce:latest"
        always_on        = "true"
    }

    identity {
        type = "SystemAssigned"
        }
    }
    ```

    + Nesta seção, fornecemos as informações do contêiner Docker .

