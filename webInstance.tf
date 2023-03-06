#  creating a security group that allow http, https traffic to get into the instance
resource "aws_security_group" "sg-1" {
  name        = var.web-sg-name
  description = "Allow http and https inbound traffic"
  vpc_id = data.aws_vpc.vpc.id
   
#  allow https, http inbound traffic
  ingress {
    description      = "HTTPS "
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


#  allow all outbound traffic from the ec2 instance
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  tags = {
    Name = "allow_http_https"
  }
}



# creating an EC2 instance within a tag name
resource "aws_instance" "my-instance" {
  ami           = var.web-ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.sg-1.id]
  subnet_id =  var.web-sub-id

#  here is my key-pair that used to authentication when access this instance by ssh
  key_name = "key-pair-dina"
  
#   the instance name 
  tags = {
    Name = var.tag-name
  }


}
