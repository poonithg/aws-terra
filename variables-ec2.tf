########################################
#        PRIV SERVER VARIABLES         #
########################################

variable "privserver" {
  type = map(string)
  default = {
    name     = "PRIVATE-EC2-DEMO"
    ami      = "ami-053b0d53c279acc90"
    itype    = "t2.medium"
    publicip = false
    keyname  = "demo-test"
  }
}

########################################
#        PUB SERVER VARIABLES          #
########################################

variable "pubserver" {
  type = map(string)
  default = {
    name    = "PUBLIC-EC2-DEMO"
    ami     = "ami-053b0d53c279acc90"
    itype   = "t2.medium"
    keyname = "demo-test"
  }
}

variable "eip_pubserver" {
  description = "ELASTIC IP FOR PUB SERVER"
  type        = string
  default     = "DEMO PUB EIP"
}
