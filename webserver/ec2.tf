data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "arthur" {
  key_name   = "arthur"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCldRNQJlOm8fa/zYl/gZvpVL1NGFyPOVdwxIYvrbTIYSo6uRThN/wgqjPnOOwL00t0xPOLCziLi17O4jTRfPuka90TukqpfFjs2qGO29WLGppY/pxxVlgLKbIOHhefgTfITKk4RsZcBNQaYzy98BZSneIrrqxZpO8ku6/YrzZ4tj+e5az2YwGIgNQ2gCIwVeK1n5ypUn96zYKFZsuYeevqmgkNdU8f3Z8vIxzmSS9dlv2Z5ZBsycfGQ2cijDdOwfddtRII8h78VD/9L6btmNaD+4i33LKQWP58p2HIzRCEeZ/hNmBPskXRNPw6YAwjA9eFJb6hymy5D0kIenD0n5MTyP3FyzzKl/xgKmMwMymkA8mgfUKXUcutvL3ZuZ/ppk8pbpcxLGex0nmH9wzyG0cuNfO/vg8ZgvKqFW67fDGmilFTF1XTBZ4MknaQC5ytXT+fE8YN8nNY3xKsv7xujE731cBVK51EVz3sPrC196CpD/lrfmEkptsra2GRvLicwIk= sven@eddy2"
}

resource "aws_instance" "magrathea" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = "${data.terraform_remote_state.vpc-network.outputs.private_subnet_ids[0]}"
  key_name = aws_key_pair.arthur.key_name

  tags = {
    Name = var.name
  }
}
