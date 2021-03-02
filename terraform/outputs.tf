output "master" {
  value = module.master.ipv4_address
}

output "minions" {
  value = module.minions.*.ipv4_address
}
