### Magrathea basic ssh start

resource "aws_security_group" "magrathea_basic" {
  name        = "allow_ssh_and_all_outbound"
  description = "Security group that allows SSH from 10.0.1.0/24 and all outgoing traffic"
  vpc_id      = "${data.terraform_remote_state.vpc-network.outputs.vpc_id}"

  ingress {
    description = "Allow SSH from 10.0.1.0/24"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_and_all_outbound"
  }
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.magrathea_basic.id
  source_security_group_id = aws_security_group.magrathea_lb.id
}



### Magrathea basic ssh stop
### Magrathea LB start

resource "aws_security_group" "magrathea_lb" {
  name        = "allow_http_from_self"
  description = "Security group that allows http from self"
  vpc_id      = "${data.terraform_remote_state.vpc-network.outputs.vpc_id}"

  ingress {
    description = "Allow https from everywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow http outbound traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"  
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow_https_from_all"
  }
}

