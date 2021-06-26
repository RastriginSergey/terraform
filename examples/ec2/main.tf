/* EC2 example withj ssh access */

provider "aws" {
  region = "eu-central-1"
  profile = "terraform"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Type = "solution-architect"
    Name = "main"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id

  tags = {
    Type = "solution-architect"
    Name = "ig"
  }
}

resource "aws_subnet" "subnet_a" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.main.id
  availability_zone = "eu-central-1a"

  tags = {
    Type = "solution-architect"
    Name = "subnet-a"
  }
}

resource "aws_route_table" "main_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "Router"
    Type = "solutions-architect"
  }
}

resource "aws_main_route_table_association" "main_route_association" {
  vpc_id      = aws_vpc.main.id
  route_table_id = aws_route_table.main_table.id
}

resource "aws_key_pair" "terraform" {
  key_name = "terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCVZLboMtCzTjt2Vq3k6TLFHm4sQA2RqndytJ8PRUZBXh4w9phdTG0z/33yV3G+66XgoyB+IhkLBgbD56RKu3tErpitSPfFV/HbvYZwu3jZjRxj/suRmnGl5sSjW8PwfFL7OIQXkWe2Kn1aTJv7D9wf53pq4U4WdOim8x43C9ynRZBZM2ozr4t/vAk4sDvQBpaFRNiBOtwSjz9O0ARXC6TzMtNr6SNR8ABtEFCdxKBBM1DNKn3m4qRREaZApbvoc7PEOYmrHy8wYrLOR8v1MLx1WOTJ5w4l25CSN0wzgBlQoRy0ur8cQRs54jzGbahQLdvt/dWcb6D/0JMeP/0EkrJ8pB00POlU4SqRca6LBSPXD1ezNMlulxoEGmvze9aOHL2DLslEhMyqP4DlFWqEzgqh1bpK+JYGnVvuURHt6A+vvk/5oZlf5Zrb2kpG62OVnKIZh+Ojrk7yiYpPkwbeRnM69LhdbU0hLIUAZrfdAzvIXXKDSzur1x9gvhDcqZx58wk= srastrigin@VONC02Z712MLVCF"

  tags = {
    Type = "solution-architect"
    Name = "terraform key"
  }
}

resource "aws_instance" "instance_1" {
  ami = "ami-0a86f18b52e547759"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet_a.id
  key_name = aws_key_pair.terraform.key_name
  associate_public_ip_address = true
  security_groups = [aws_security_group.sg.id]

  depends_on = [aws_internet_gateway.ig, aws_key_pair.terraform]

  tags = {
    Type = "solution-architect"
    Name = "instance-1"
  }
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "allow_ssh_ingress" {
  from_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.sg.id
  to_port = 22
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ssh_egress" {
  from_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.sg.id
  to_port = 22
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
}
