<<<<<<< HEAD
output "master" {
  value = module.master.ipv4_address
}

output "minions" {
  value = module.minions.*.ipv4_address
=======
output "name" {
  value = module.record.*.hostname
>>>>>>> 1b0125e93b915f84ea48fe44ab889fef380726e6
}
