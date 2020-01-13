output "aws_elb_api_id" {
  value = "${aws_elb.aws-elb-api.id}"
}

output "aws_elb_api_fqdn" {
  value = "${aws_elb.aws-elb-api.dns_name}"
}

output "aws_elb_api_sg" {
  value = "${aws_security_group.aws-elb.id}"
}