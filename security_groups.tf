resource "outscale_security_group" "ec2_sg" {
  net_id              = outscale_net.main_vpc.net_id
  description         = "Allow inbound SSH traffic and http from any IP"
  security_group_name = "ec2_sg"
  tags {
    key   = "Name"
    value = "Allow SSH and HTTP in ec2 instances"
  }
}

resource "outscale_security_group_rule" "ec2_sg_http_rule" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.ec2_sg.security_group_id
  from_port_range   = "80"
  to_port_range     = "80"
  ip_protocol       = "tcp"
  ip_range          = "0.0.0.0/0"
}

resource "outscale_security_group_rule" "ec2_sg_https_rule" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.ec2_sg.security_group_id
  from_port_range   = "443"
  to_port_range     = "443"
  ip_protocol       = "tcp"
  ip_range          = "0.0.0.0/0"
}

resource "outscale_security_group_rule" "ec2_sg_ssh_rule" {
  flow              = "Inbound"
  security_group_id = outscale_security_group.ec2_sg.security_group_id
  from_port_range   = "22"
  to_port_range     = "22"
  ip_protocol       = "tcp"
  ip_range          = "0.0.0.0/0"
}
