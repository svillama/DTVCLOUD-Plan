### Substitute USERNAME to correct the path
### Substitute the OCIDs, fingerprints and keys with the correct ones for your environment
### File for Linux and OS X Users in shell environment
### Authentication details
$env:TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaazwd7gjoxwqagc6uos3mak37qqfsr2i547jbm33a4r6jafhddwsgq"
$env:TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaatk5svqtibnh5m4wplhd2xuqdypnasoyobq6gr2mcdxno6auatr6a"
$env:TF_VAR_fingerprint="22:e6:8a:59:04:2d:4b:21:4a:47:c8:08:10:4c:0f:df"
$env:TF_VAR_private_key_path= "C:\Users\svillama\.oci\oci_api_key.pem"

### Compartment
$env:TF_VAR_compartment_ocid="ocid1.compartment.oc1..aaaaaaaaunxv32uu2kijiwvm6nhjuzssdiyg5hd5cakcsmusrlhk4ooxzw4a"

### Public/private keys used on the instances
$env:TF_VAR_ssh_public_key = Get-Content C:\Users\svillama\.ssh\id_rsa.pub -Raw
$env:TF_VAR_ssh_private_key = Get-Content C:\Users\svillama\.ssh\id_rsa -Raw


### Region
$env:TF_VAR_region="us-ashburn-1"
