resource "outscale_public_ip" "ec2_public_ip" {
  tags {
    key   = "name"
    value = "ec2 instance public ip"
  }
}

resource "outscale_vm" "appserver" {
  image_id           = var.ami_id
  vm_type            = var.instance_type
  keypair_name       = var.keypair_name
  security_group_ids = [outscale_security_group.ec2_sg.id]
  subnet_id          = outscale_subnet.subnet_public.id
  depends_on         = [outscale_public_ip.ec2_public_ip]

  block_device_mappings {
    device_name = "/dev/sda1" # /dev/sda1 corresponds to the root device of the VM
    bsu {
      volume_size = 20 #GiB
    }
  }

  tags {
    key   = "name"
    value = "terraform-public-vm"
  }

  tags {
    key   = "osc.fcu.eip.auto-attach"
    value = outscale_public_ip.ec2_public_ip.public_ip
  }
  user_data = base64encode(file("./resources/init.sh"))
}
