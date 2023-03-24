resource "aws_instance" "web" {
  ami           =  "ami-0f2eac25772cd4e36"
  instance_type = "t2.micro"
  key_name   = "singapore"
  subnet_id = var.public_subnet 
  vpc_security_group_ids = [aws_security_group.bharathsecurity.id]
  user_data = <<-EOF
              #!/bin/bash
              sudo su
              sudo yum install httpd -y
              echo "Hello this is bharath" > /var/www/html/index.html
              sudo yum update -y
              sudo service httpd start
              EOF


  tags = {
    Name = "Terraform"
  }
}



  
