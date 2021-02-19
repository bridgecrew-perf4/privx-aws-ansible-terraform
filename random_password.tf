resource "random_password" "database_password" {
  length           = 20
  special          = true
  override_special = "!#%-_=+"
}

resource "random_password" "superuser_password" {
  length           = 20
  special          = true
  override_special = "!@#%-_=+"
}