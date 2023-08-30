#### DETAILS ABOUT THE DEMO PUBLIC SERVER ####
resource "aws_instance" "ec2-demo-pub" {
  ami                    = lookup(var.pubserver, "ami")
  instance_type          = lookup(var.pubserver, "itype")
  user_data              = file("userdata/setup-nginx.sh")
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.sg-pub.id]

  tags = {
    Name       = lookup(var.pubserver, "name")
    MANAGED_BY = "TERRAFORM"
  }

  key_name = lookup(var.pubserver, "keyname")

  depends_on = [aws_security_group.sg-pub]
}


# AWS EIP
resource "aws_eip" "eip_pubserver" {
  instance = aws_instance.ec2-demo-pub.id
  domain   = "vpc"

  tags = {
    Name       = var.eip_pubserver
    MANAGED_BY = "TERRAFORM"
  }

}

# AWS EIP ASSOCIATION
resource "aws_eip_association" "eip_assoc_pubserver" {
  instance_id   = aws_instance.ec2-demo-pub.id
  allocation_id = aws_eip.eip_pubserver.id
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
