########################################
#	NETWORK VARIABLES              #
########################################
variable "region" {
  description = "AWS REGION"
  type        = string
  default     = "us-east-1"
}

variable "vpc" {
  description = "VPC NAME"
  type        = string
  default     = "demo-vpc"
}

variable "vpc-cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ig" {
  description = "INTERNET GATEWAY NAME"
  type        = string
  default     = "ig-demo"
}

variable "nat" {
  description = "NAT NAME"
  type        = string
  default     = "nat-demo"
}

variable "subnet-pub" {
  description = "SUBNET NAME"
  type        = string
  default     = "demo-subnet-pub"
}

variable "subnet-priv" {
  description = "SUBNET NAME"
  type        = string
  default     = "demo-subnet-priv"
}

variable "subnet-cidr-pub" {
  description = "SUBNET CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet-cidr-priv" {
  description = "SUBNET CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet-cidr-pub-az" {
  description = "SUBNET AZ"
  type        = string
  default     = "us-east-1a"
}

variable "subnet-cidr-priv-az" {
  description = "SUBNET AZ"
  type        = string
  default     = "us-east-1b"
}

variable "route-table-priv" {
  description = "PRIVATE ROUTE TABLE"
  type        = string
  default     = "route-table-priv-demo"
}

variable "route-table-pub" {
  description = "PUBLIC ROUTE TABLE"
  type        = string
  default     = "route-table-pub-demo"
}

variable "priv-sg" {
  description = "PRIVATE SECURITY GROUP"
  type        = string
  default     = "private-sg-demo"
}

variable "pub-sg" {
  description = "PUBLIC SECURITY GROUP"
  type        = string
  default     = "public-sg-demo"
}
