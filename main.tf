terraform {
  backend "swift" {
    container = "docker-env-tf-remote-state"
  }
}

provider "openstack" {
  version     = "= 1.8"
  region      = "${var.region_a}"
  alias = "region_a"
}

data "openstack_networking_network_v2" "public_a" {
  name     = "Ext-Net"
  provider = "openstack.region_a"
}

resource "openstack_networking_port_v2" "public_a" {
  count          = "${var.count}"
  name           = "${var.name}_a_${count.index}"
  network_id     = "${data.openstack_networking_network_v2.public_a.id}"
  admin_state_up = "true"
  provider       = "openstack.region_a"
}

resource "openstack_compute_keypair_v2" "keypair_a" {
  name       = "${var.name}"
  public_key = "${file(var.ssh_public_key)}"
  provider   = "openstack.region_a"
}


data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    customterm_file = "${path.module}/customterm.sh"
    zshrc_file      = "${path.module}/zshrc"
    vimrc_file      = "${path.module}/vimrc"
  }
}

resource "openstack_compute_instance_v2" "nodes_a" {
  count       = "${var.count}"
  name        = "${var.name}_a_${count.index}"
  image_name  = "Ubuntu 18.04"
  flavor_name = "${var.flavor_name}"
  key_pair    = "${openstack_compute_keypair_v2.keypair_a.name}"
  user_data   = "${data.template_file.userdata.rendered}"

  network {
    access_network = true
    port           = "${openstack_networking_port_v2.public_a.*.id[count.index]}"
  }

  provider = "openstack.region_a"

}

resource "null_resource" "provision_a" {
  count = "${var.count}"

  triggers {
    id = "${openstack_compute_instance_v2.nodes_a.*.id[count.index]}"
  }

  connection {
    host = "${openstack_compute_instance_v2.nodes_a.*.access_ip_v4[count.index]}"
    user = "ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]
  }

#  provisioner "file" {
#    source      = "./www/public"
#    destination = "/home/ubuntu/${var.name}"
#  }
}
