# Specify the provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a key pair (or you can reference an existing key pair)
resource "aws_key_pair" "my_key" {
  key_name   = "web01_kp" # Replace with your actual key name
  public_key = file("~/.ssh/web01_kp.pub") # Path to your public key
}

# Create a security group to allow SSH and HTTP
resource "aws_security_group" "my_security_group" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows HTTP traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

# Launch an EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Replace with your AMI ID
  instance_type = "t2.micro" # Instance type (free-tier eligible)

  # Associate the security group and key pair
  security_groups = [aws_security_group.my_security_group.name]
  key_name        = aws_key_pair.my_key.key_name

  # Tags (optional)
  tags = {
    Name = "MyEC2Instance"
  }
}

# Output the public IP address of the EC2 instance
output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}

