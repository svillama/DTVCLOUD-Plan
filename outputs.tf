##########
# Outputs
##########
output "Username" {
  value = ["${data.oci_core_instance_credentials.InstanceCredentials.username}"]
}

output "Password" {
#  value = ["${random_string.instance_password.result}"]
  value = ["Passw0rd"]
}

output "InstancePublicIP" {
  value = ["${oci_core_instance.TFInstance.public_ip}"]
}

output "InstancePrivateIP" {
  value = ["${oci_core_instance.TFInstance.private_ip}"]
}
