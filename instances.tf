resource "aws_instance" "web-server1" {
  ami                    = nonsensitive(data.aws_ssm.parameter.ami.value)
  instance_type          = var.aws_instance_sizes.small
  subnet_id              = aws_subnet.dev-subnet-1
  vpc_security_group_ids = [aws_security_group.sg1.id]

  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>abdul Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF
}

resource "aws_instance" "web-server2" {
  ami = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type = var.instance_type
  subnet_id = aws_subnet.dev-subnet-2.id
  vpc_security_group_ids = [aws_security_group.sg1.id]

  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>abdul server 2</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF

  tags = local.common_tags
}