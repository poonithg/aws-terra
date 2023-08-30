#### DETAILS ABOUT THE DEMO PRIVATE SERVER ####
resource "aws_instance" "ec2-demo-priv" {
  ami           = lookup(var.privserver, "ami")
  instance_type = lookup(var.privserver, "itype")
  user_data     = file("userdata/setup-node.sh")

  network_interface {
    network_interface_id = aws_network_interface.ec2-priv-nic.id
    device_index         = 0
  }

  tags = {
    Name       = lookup(var.privserver, "name")
    MANAGED_BY = "TERRAFORM"
  }

  key_name = lookup(var.privserver, "keyname")

  depends_on = [aws_security_group.sg-priv]
}

# AWS ELASTIC NETWORK NETWORK FOR PRIVATE VM
resource "aws_network_interface" "ec2-priv-nic" {
  subnet_id       = aws_subnet.private_subnet.id
  private_ips     = ["10.0.2.100"]
  security_groups = [aws_security_group.sg-priv.id]
}

# AWS EBS VOLUME
#resource "aws_ebs_volume" "ec2-priv-ebs-01" {
#  availability_zone = var.subnet-cidr-priv-az
#  size              = 40
#  type              = "gp2"

#  tags = {
#    Name       = "EC2-PRIV-VOL-01"
#    MANAGED_BY = "TERRAFORM"
#  }
#}

# AWS EBS VOLUME ATTACHMENT
#resource "aws_volume_attachment" "ec2-priv-ebs-01-attach" {
#  device_name = "/dev/xvdf"
#  volume_id   = aws_ebs_volume.ec2-priv-ebs-01.id
#  instance_id = aws_instance.ec2-demo-priv.id
#}
