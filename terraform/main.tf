module "ssh_key" {
  source     = "robertdebock/ssh_key/digitalocean"
  version    = "2.0.0"
  name       = "Robert de Bock"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCWswOogkZz/ihQA0lENCwDwSzmtmBWtFwzIzDlfa+eb4rBt6rZBg7enKeMqYtStI/NDneBwZUFBDIMu5zJTbvg7A60/WDhWXZmU21tZnm8K7KREFYOUndc6h//QHig6IIaIwwBZHF1NgXLtZ0qrUUlNU5JSEhDJsObMlPHtE4vFP8twPnfc7hxAnYma5+knU6qTMCDvhBE5tGJdor4UGeAhu+SwSVDloYtt1vGTmnFn8M/OD/fRMksusPefxyshJ37jpB4jY/Z9vzaNHwcj33prwl1b/xRfxr/+KRJsyq+ZKs9u2TVw9g4p+XLdfDtzZ8thR2P3x3MFrZOdFmCbo/5"
}

module "vpc" {
  source   = "robertdebock/vpc/digitalocean"
  version  = "1.0.0"
  name     = "salt"
}

module "master" {
  source    = "robertdebock/droplet/digitalocean"
  version   = "1.0.0"
  name      = "master.meinit.nl"
  image     = "ubuntu-20-04-x64"
  ssh_keys  = [module.ssh_key.id]
  size      = "s-1vcpu-1gb"
  vpc_uuid  = module.vpc.id
  user_data = "#!/bin/sh\ncurl -L https://bootstrap.saltstack.com -o install_salt.sh\nsudo sh install_salt.sh -P -M -x python3"
}

module "minions" {
  source    = "robertdebock/droplet/digitalocean"
  version   = "1.0.0"
  name      = "minion-${count.index}.meinit.nl"
  image     = "78889075"
  ssh_keys  = [module.ssh_key.id]
  count     = var.amount
  size      = "4gb"
  vpc_uuid  = module.vpc.id
  user_data = "#!/bin/sh\ncurl -L https://bootstrap.saltstack.com -o install_salt.sh\nsudo sh install_salt.sh -P -x python3"
}

data "cloudflare_zones" "default" {
  filter {
    name = "meinit.nl"
  }
}

module "masterrecord" {
  source  = "robertdebock/record/cloudflare"
  version = "1.0.0"
  name    = "master"
  type    = "A"
  value   = module.master.ipv4_address
  zone_id = data.cloudflare_zones.default.zones[0].id
}

module "minionrecords" {
  source  = "robertdebock/record/cloudflare"
  version = "1.0.0"
  name    = "minion-${count.index}"
  type    = "A"
  value   = module.minions[count.index].ipv4_address
  zone_id = data.cloudflare_zones.default.zones[0].id
  count   = var.amount
}
