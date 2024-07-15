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
