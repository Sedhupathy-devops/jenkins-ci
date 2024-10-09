terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-south-1"
}

resource "aws_key_pair" "jenkins-key" {
  key_name   = "jenkins-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDxBTEsasP+KJpDLH6HQ/jNYJcBrUdXyHJXxfzItU//6pQuhVjRfVKf5yJklXVJYM8bYsJGXiVFN7dSrM/Zr08Vu4pAKp6mJZ9hof5SxB6RC0rTRtBWym4xDr7z6f46s1ocTKf1SHV3Ej5bQv/BiWF3XhyTJiIewjcb1AbuFapirGybzJFv88IBIVmMXvKDo2yK+QOtQzLzJkoiSoLNs5qDJRigtD0kAKyl/gnS72SSaVWG+ATqP7fjViPkw829DPz96bCUoWn2xJQrspE39nuN3Je1r7fKMb6ltCriTNBMiz+4MuE7+u5keCVQ4TCGofJ0PLfTfUvJH3PyFUKqOxOBFJF+z0BSSb8HlLER9f8dp+fzPtYeD2Zsbm2YaczYygzEf9RfZf9iKofxi+A3s4AONWNcLlojnVwwtTR0EU2Fgu3t+miOUD4c/+84lsZM/du7IXwCzyciO/tnS6YXCPbE9MEoEArXT/3lDtAIz9yNkhKEVXivKEYSM55asGWoF3q1GrGSy9sxvY58WuhXD0Q28Rdi32yTIX0JKhU8qirSoRlqETV5cSRE9DvarJEwYhKmFeKkHXzXamuGD34DlrxsvJNgqnp8ULNOgAtW9lmHeArm04iCy3jdDJgix3qHFmzsKjqBIxY8uGpldL6xb+5ZpFX9baQtR2TXQNBFwLXxNw== jenkins@ip-172-31-10-63"
}

resource "aws_instance" "example_server" {
  ami           = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.micro"
  key_name = aws_key_pair.jenkins-key.key_name
  tags = {
    Name = "webserver"
  }
}

output "ec2_ip" {
  value = "${aws_instance.example_server.public_ip}"
}
