data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "example" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.example.id

  tags = {
    Name = var.name,
    Environment = "${terraform.workspace}"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} ${self.id} >> /tmp/hosts.txt"
  }
}

resource "aws_key_pair" "example" {
  key_name = "${terraform.workspace}"
  public_key = file("./example.pub")
}

