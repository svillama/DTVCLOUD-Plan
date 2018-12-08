variable "instance_Linuxname" {
  default = "Linux-JENKINS"
}

variable "ImageOS" {
  default = "Oracle Linux"
}

variable "ImageOSVersion" {
  default = "7.4"
}

variable "ssh_public_key" {}

resource "oci_core_instance" "Linux-JENKINS" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain - 1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "Linux-JENKINS"
  shape               = "${var.instance_shape}"

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.ExampleSubnet.id}"
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = "tfexampleinstance"
  }

  source_details {
    boot_volume_size_in_gbs = "${var.size_in_gbs}"
    source_id               = "${var.instance_image_ocid_Linux[var.region]}"
    source_type             = "image"
  
  }

  ###################
  # Orig
  # source_details {
  # source_type = "image"
  # source_id   = "${lookup(data.oci_core_images.TFSupportedShapeImages.images[0], "id")}"
  #}

###############################
  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
  }

  timeouts {
    create = "60m"
  }

}

resource "oci_core_image" "TFCustomImage" {
  compartment_id = "${var.compartment_ocid}"
  instance_id    = "${oci_core_instance.TFInstance.id}"

  launch_mode = "NATIVE"

  timeouts {
    create = "30m"
  }
}
