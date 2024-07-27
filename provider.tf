terraform {
  required_providers {
    outscale = {
      source = "outscale/outscale"
    }
  }
}

provider "outscale" {
  access_key_id = var.access_key
  secret_key_id = var.secret_key
  region        = var.region
  endpoints {
    api = var.endpoint_api
  }
}

