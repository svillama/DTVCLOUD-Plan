############
# Variables
############
variable "tenancy_ocid" {}

variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

variable "compartment_ocid" {}

variable "cloudinit_ps1" {
  default = "cloudinit.ps1"
}

variable "cloudinit_config" {
  default = "cloudinit.yml"
}

variable "setup_ps1" {
  default = "setup.ps1"
}

variable "userdata" {
  default = "userdata"
}

variable "size_in_gbs" {
  default = "254"
}

####################
# Default Name - SAV
####################
#variable "instance_name" {
#  default = "TFWindows"
#}

variable "instance_user" {
  default = "opc"
}

variable "availability_domain" {
  default = "1"
}

variable "instance_shape" {
  default = "VM.Standard2.1"
}

variable instance_image_ocid_Windows {
  type = "map"

  default = {
    # Images released in and after July 2018 have cloudbase-init and winrm enabled by default, refer to the release notes - https://docs.cloud.oracle.com/iaas/images/
    # Image OCIDs for Windows-Server-2016-Standard-Edition-VM-Gen2-2018.11.16-0 - https://docs.cloud.oracle.com/iaas/images/windows-server-2016-vm/
   
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaakctcuxjnna2jojsypta54lrxx5rsqw5lmwuhj5yggs4jrxzphvza"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaav3jfxfznpfrhoesdsv35xgdyircwqffdpjiq3uvd657iygqzokia"
    uk-london-1  = "ocid1.image.oc1.uk-london-1.aaaaaaaad5ntypw5sg6kke7uawd2kpx4ltxnotqrjnean7syufgzpwwhnekq"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaark5b6ueosy7onatjwtv27occrl4oqtkrndchp5zh4otrkjpxda3q"
  }
}

variable instance_image_ocid_Linux {
  type = "map"

  default = {
    # Images released in and after July 2018 have cloudbase-init and winrm enabled by default, refer to the release notes - https://docs.cloud.oracle.com/iaas/images/
    # Image OCIDs for Oracle-Linux-7.6-2018.11.19-0 - https://docs.cloud.oracle.com/iaas/images/image/2c38d2ad-13c3-4b27-a546-2341faf1a74a/
   
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa2rvnnmdz6ewn4pozatb2l6sjtpqpbgiqrilfh3b4ee7salrwy3kq"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaa2mnepqp7wn3ej2axm2nkoxwwcdwf7uc246tcltg4li67z6mktdiq"
    uk-london-1  = "ocid1.image.oc1.uk-london-1.aaaaaaaaikjrglbnzkvlkiltzobfvtxmqctoho3tmdcwopnqnoolmwbsk3za"
    us-phoenix-1 = 	"ocid1.image.oc1.phx.aaaaaaaaaujbtv32uv4mizzbgnjkjlvbeaiqj5sgc6r5umfunebt7qpzdzmq"
  }
}

############
# Provider
############
provider "oci" {
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region           = "${var.region}"
}
