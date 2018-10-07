variable "region_a" {
  description = "The id of the first openstack region"
  default = "GRA5"
}

variable "name" {
  description = "project name."
  default = "openstack_docker_env"
}

variable "ssh_public_key" {
  description = "The path of the ssh public key that will be used"
  default     = "~/.ssh/id_rsa_new2.pub"
}

variable "flavor_name" {
  description = "flavor name of nodes."
  default     = "s1-2"
}

variable "count" {
  description = "number of nodes per region"
  default     = 1
}

variable "zone" {
  description = "the domain root zone"
}
