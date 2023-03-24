resource "aws_instance" "web" {
  ami           =  "ami-0f2eac25772cd4e36"
  instance_type = "t2.micro"
  key_name   = "singapore"
  subnet_id = aws_subnet.Public_subnet[1].id
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

resource "aws_security_group" "bharathsecurity" {
  name        = "allow_port80"
  description = "Allow Inbound Traffic on Port 80"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Port 80 from Everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }
}

terraform{
    backend "s3"{
        bucket = "terraform2702"
        key = "new/terraform.tfstate"
        region = "ap-southeast-1"
        encrypt = true
        dynamodb_table = "terraform2702"
    }
}    
    
