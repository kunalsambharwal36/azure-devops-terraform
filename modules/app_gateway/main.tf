resource "azurerm_public_ip" "appgw" {
  name                = "kml-appgw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"
}

resource "azurerm_application_gateway" "main" {
  name                = "kml-appgw"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name = "Basic"
    tier = "Basic"
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = var.app_gateway_subnet_id
  }

  frontend_ip_configuration {
    name                 = "public-frontend"
    public_ip_address_id = azurerm_public_ip.appgw.id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  backend_address_pool {
    name         = "app-backend"
    ip_addresses = var.backend_private_ips
  }

  backend_http_settings {
    name                  = "http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "public-frontend"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  probe {
    name                                      = "http-probe"
    protocol                                  = "Http"
    path                                      = "/"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
  }

  request_routing_rule {
    name      = "http-routing-rule"
    rule_type = "Basic"
    priority  = 100

    http_listener_name         = "http-listener"
    backend_address_pool_name  = "app-backend"
    backend_http_settings_name = "http-settings"
  }
}