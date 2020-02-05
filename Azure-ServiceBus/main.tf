# Configure the Azure Provider
provider "azurerm" {
  subscription_id = "9975c008-7032-4464-874a-e5439f515e1e"
  tenant_id       = "a06a7d03-124b-489c-b932-1d12f11dc4e2"
}
resource "azurerm_resource_group" "example" {
  name = "${var.prefix}-resources"

  location = "${var.location}"
}

resource "azurerm_servicebus_namespace" "example" {
  name = "${var.prefix}-sbnamespace"

  location = "${azurerm_resource_group.example.location}"

  resource_group_name = "${azurerm_resource_group.example.name}"

  sku = "Standard"
}

resource "azurerm_servicebus_namespace_authorization_rule" "example" {
  name = "${var.prefix}-sbnauth"

  namespace_name = "${azurerm_servicebus_namespace.example.name}"

  resource_group_name = "${azurerm_resource_group.example.name}"

  send = true

  listen = true

  manage = true
}

resource "azurerm_servicebus_topic" "example" {
  name = "${var.prefix}-sbtopic"

  resource_group_name = "${azurerm_resource_group.example.name}"

  namespace_name = "${azurerm_servicebus_namespace.example.name}"

  enable_partitioning = true
}

resource "azurerm_servicebus_subscription" "example" {
  name = "${var.prefix}-sbsubscription"

  resource_group_name = "${azurerm_resource_group.example.name}"

  namespace_name = "${azurerm_servicebus_namespace.example.name}"

  topic_name = "${azurerm_servicebus_topic.example.name}"

  max_delivery_count = 1
}

resource "azurerm_servicebus_queue" "example" {
  name = "${var.prefix}-sbqueue"

  resource_group_name = "${azurerm_resource_group.example.name}"

  namespace_name = "${azurerm_servicebus_namespace.example.name}"

  enable_partitioning = true
}
