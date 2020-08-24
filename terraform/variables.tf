variable "mgmt_home_ip" {
    type = string
    default = "0.0.0.0/0"
}

variable "key_name" {
    type = string
    default = "c2"
}

variable "ami_id" {
    type = string
    default = "ami-123456"
}

variable "instance_size" {
    type = string
    default = "t2.micro"
}

variable "root_volume_size" {
    type = string
    default = "10"
}