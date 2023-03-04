#resources i will be adding
# 1. aws_lb
resource "aws_lb" "web-server" {
  name               = "my-web-servers"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg2.id]
  subnets            = [aws_subnet.dev-subnet-1,aws_subnet.dev-subnet-2]

  enable_deletion_protection = true

  tags = local.common_tags  
}

# 2. aws_lb_target_group

resource "aws_lb_target_group" "webserver" {
  name     = "webserverTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.dev-vpc.id
}

# 3. aws_lb_listener

resource "aws_lb_listener" "webserverlis" {
  load_balancer_arn = aws_lb.web-server.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver.arn
  }
}

# 4. aws_lb target_group_attachment

resource "aws_lb_target_group_attachment" "webtestattache" {
  target_group_arn = aws_lb_target_group.webserver.arn
  target_id        = aws_instance.web-server1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "webtestattache2" {
  target_group_arn = aws_lb_target_group.webserver.arn
  target_id        = aws_instance.web-server2.id
  port             = 80
}