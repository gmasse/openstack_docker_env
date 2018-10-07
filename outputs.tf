output "helper" {
  description = "human friendly helper"
  value = <<DESC

openstack_compute_instance_v2.nodes_a:
  id = "${openstack_compute_instance_v2.nodes_a.id}"
  access_ip_v4 = "${openstack_compute_instance_v2.nodes_a.access_ip_v4}"

---
DESC
}
