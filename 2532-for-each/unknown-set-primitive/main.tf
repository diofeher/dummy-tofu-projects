resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  prefix_list_ids   = ["123"]
  from_port         = 0
  security_group_id = "sg-123456"
}

resource "null_resource" "a" {
  for_each = toset([aws_security_group_rule.allow_all.to_port])
}
