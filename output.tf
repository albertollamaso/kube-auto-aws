

output "masters" {
  value = "${join("\n", aws_instance.k8s-master.*.public_ip)}"
}

output "workers" {
  value = "${join("\n", aws_instance.k8s-worker.*.public_ip)}"
}

output "inventory" {
  value = "${data.template_file.inventory.rendered}"
}

output "default_tags" {
  value = "${var.default_tags}"
}
