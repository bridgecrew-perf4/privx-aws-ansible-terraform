data "aws_ami" "centos7" {
  owners = [
  "679593333241"]
  most_recent = true

  filter {
    name = "name"
    values = [
    "CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name = "architecture"
    values = [
    "x86_64"]
  }

  filter {
    name = "root-device-type"
    values = [
    "ebs"]
  }
}

resource "aws_instance" "privx" {
  ami                    = data.aws_ami.centos7.id
  instance_type          = var.instance_typeprivx
  vpc_security_group_ids = [aws_security_group.privx.id]
  subnet_id              = aws_default_subnet.subnet_1.id
  root_block_device {
    delete_on_termination = true
  }
  associate_public_ip_address = true
  depends_on                  = [module.pgsql_database, module.redis_cache]
  key_name                    = var.key_name

  tags = {
    Name = "privx_terraform"
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --region ${var.region} --instance-ids ${self.id} && ansible-playbook --tags 'install,configure' --extra-vars 'passed_in_hosts=tag_Name_${self.tags.Name} remote_username=${var.os_username} public_fqdn=${var.public-fqdn} privx_superuser=${var.privx_superuser} superuser_password=${random_password.superuser_password.result} email_domain=${var.email_domain} database_name=${var.database_name} database_username=${var.database_username} database_password=${random_password.database_password.result} postgres_address=${module.pgsql_database.database_address} redis_address=${module.redis_cache.redis_address}' ansible/deploy.yml"
  }
}

resource "aws_instance" "privx_1" {
  count                  = var.additional_privx_instance_count
  ami                    = data.aws_ami.centos7.id
  instance_type          = var.instance_typeprivx
  vpc_security_group_ids = [aws_security_group.privx.id]
  subnet_id              = aws_default_subnet.subnet_2.id
  root_block_device {
    delete_on_termination = true
  }
  associate_public_ip_address = true
  depends_on                  = [aws_instance.privx]
  key_name                    = var.key_name

  tags = {
    Name = join("_", ["privx_terraform", count.index + 1])
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --region ${var.region} --instance-ids ${self.id} && ansible-playbook --tags 'backup' --extra-vars 'passed_in_hosts=tag_Name_${aws_instance.privx.tags.Name} remote_username=${var.os_username}' ansible/deploy.yml && ansible-playbook --tags 'install,configure_addtional' --extra-vars 'passed_in_hosts=tag_Name_${self.tags.Name} remote_username=${var.os_username} privx_first=${aws_instance.privx.public_ip}' ansible/deploy.yml"
  }
}
