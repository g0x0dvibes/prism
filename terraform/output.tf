output "instance_ips" {
  value = ["${aws_instance.prism_c2.*.public_ip}"]
}