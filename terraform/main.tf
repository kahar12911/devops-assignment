provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "web" {
  ami                    = "ami-04b4f1a9cf54c11d0"  # Ubuntu 20.04 AMI
  instance_type          = var.instance_type
  security_groups        = [aws_security_group.web_sg.name]
  key_name               = "terraform-key" # Replace with your AWS key pair name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              echo "Deployed via Terraform" > /var/www/html/index.html
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name        = "nginx-web-${var.environment}"
    Environment = var.environment
  }
}
