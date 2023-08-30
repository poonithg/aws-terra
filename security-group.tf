#### PRIVATE SECURITY GROUP ####
resource "aws_security_group" "sg-priv" {
  name        = var.priv-sg
  description = "Default SG to alllow traffic from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on = [
    aws_vpc.vpc
  ]

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port        = "0"
    to_port          = "0"
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name       = var.priv-sg
    MANAGED_BY = "TERRAFORM"
  }
}

#### PUBLIC SECURITY GROUP ####
resource "aws_security_group" "sg-pub" {
  name        = var.pub-sg
  description = "SG to alllow traffic from outside"
  vpc_id      = aws_vpc.vpc.id
  depends_on = [
    aws_vpc.vpc
  ]

  ingress {
    description = "GIRISH SSH ACCESS"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["102.113.22.214/32"]
  }

  ingress {
    description = "GIRISH HTTP ACCESS"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["102.113.22.214/32"]
  }

  egress {
    from_port        = "0"
    to_port          = "0"
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name       = var.pub-sg
    MANAGED_BY = "TERRAFORM"
  }

}
