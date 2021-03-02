terraform {
<<<<<<< HEAD
  required_version = ">= 0.14.6"
=======
  required_version = ">= 0.13"
>>>>>>> 1b0125e93b915f84ea48fe44ab889fef380726e6
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.2.0"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.2.0"
    }
  }
<<<<<<< HEAD
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
=======
>>>>>>> 1b0125e93b915f84ea48fe44ab889fef380726e6
}
