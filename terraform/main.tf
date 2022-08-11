resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "tf-example"
  }
}

resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["10.0.1.100"]
  tags = {
    Name = "tf-example"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-06cd52961ce9f0d85"
  instance_type = "t3.micro"
  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
}