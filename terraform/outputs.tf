output "master" {
  value = module.masterrecord.hostname
}

output "minions" {
  value = module.minionrecords.*.hostname
}
