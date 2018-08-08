provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-west-2"
}

resource "aws_spot_instance_request" "spot-ec2-test" {
  ami = ""
  count = "1"
  spot_type = "one-time"
  spot_price = "2.0"
  instance_type = "c4.large"

}