############
# Cloudinit
############
# Generate a new strong password for your instance
resource "random_string" "instance_password" {
  length  = 6
  special = true
}

# Use the cloudinit.ps1 as a template and pass the instance name, user and password as variables to same
data "template_file" "cloudinit_ps1" {
  vars {
    instance_user     = "${var.instance_user}"
  instance_password = "Passw0rd"
  #  instance_password = "${random_string.instance_password.result}"
    instance_name     = "SV-SRVAD01"
  }

  template = "${file("${var.userdata}/${var.cloudinit_ps1}")}"
}

data "template_cloudinit_config" "cloudinit_config" {
  gzip          = false
  base64_encode = true

  # The cloudinit.ps1 uses the #ps1_sysnative to update the instance password and configure winrm for https traffic
  part {
    filename     = "${var.cloudinit_ps1}"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.cloudinit_ps1.rendered}"
  }

  # The cloudinit.yml uses the #cloud-config to write files remotely into the instance, this is executed as part of instance setup
  part {
    filename     = "${var.cloudinit_config}"
    content_type = "text/cloud-config"
    content      = "${file("${var.userdata}/${var.cloudinit_config}")}"
  }
}

###########
# Compute
###########

resource "oci_core_instance" "TFInstance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain - 1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "SV-SRVAD01"
  shape               = "${var.instance_shape}"
  subnet_id           = "${oci_core_subnet.ExampleSubnet.id}"
  hostname_label      = "winmachine"

  # Refer cloud-init in https://docs.cloud.oracle.com/iaas/api/#/en/iaas/20160918/datatypes/LaunchInstanceDetails
  metadata {
    # Base64 encoded YAML based user_data to be passed to cloud-init
    user_data = "${data.template_cloudinit_config.cloudinit_config.rendered}"
  }

  source_details {
    boot_volume_size_in_gbs = "${var.size_in_gbs}"
    source_id               = "${var.instance_image_ocid_Windows[var.region]}"
    source_type             = "image"
  }
}

data "oci_core_instance_credentials" "InstanceCredentials" {
  instance_id = "${oci_core_instance.TFInstance.id}"
}

resource "oci_core_volume" "TFVolume" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain - 1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "tfvolume"
  size_in_gbs         = "${var.size_in_gbs}"
}

resource "oci_core_volume_attachment" "TFVolumeAttachment" {
  attachment_type = "iscsi"
  compartment_id  = "${var.compartment_ocid}"
  instance_id     = "${oci_core_instance.TFInstance.id}"
  volume_id       = "${oci_core_volume.TFVolume.id}"
}

