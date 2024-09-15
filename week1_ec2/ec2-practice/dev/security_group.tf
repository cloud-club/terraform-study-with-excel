resource "aws_security_group" "terraform-ec2-enable-http" {
  vpc_id = module.vpc.vpc_id
  name = "${var.project_name}-${var.target_label}-sg"
  description = "EC2 Security Group"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group_rule" "terraform-ec2-enable-http-i" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform-ec2-enable-http.id

  lifecycle {
    create_before_destroy = true
  }
}