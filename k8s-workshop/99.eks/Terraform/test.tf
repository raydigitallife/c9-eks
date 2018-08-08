provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-west-2"
}

variable "ami" {
    # ami = "ami-a9d09ed1"
    # default = "ami-a9d09ed1"
    # default = "ami-12345667"
    type = "map"
    default = {
        "orga" = "ami-a9d09ed1"
        "texst"  = "ami-12345678"
    }

    
}
/* 
data "aws_ami" "web" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Component"
    values = ["web"]
  }

  most_recent = true
}
*/

resource "aws_spot_instance_request" "spot-ec2-test" {
  ami = "${lookup(var.ami, map) }"
  count = "1"
  spot_type = "one-time"
  spot_price = "2.0"
  instance_type = "c4.large"

}

resource "aws_spot_fleet_request" "spot-fleet" {
  
}
