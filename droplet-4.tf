resource "digitalocean_droplet" "droplet-4" {
    image = "ubuntu-20-04-x64"
    name = "droplet-4"
    region = "ams3"
    size = "s-1vcpu-1gb"
    private_networking = true
    ssh_keys = [
      data.digitalocean_ssh_key.terraform.id
    ]

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install basic deps
      "sudo apt update",
      "sudo apt-get -y install ca-certificates curl gnupg sb-release",
      # Docker
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt update",
      "sudo apt-get -y install docker-ce docker-ce-cli containerd.io",
      "docker run -ti --rm alpine/bombardier -c 300 -H \"user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.109\" -d 5000s -l --rate 1000 host:port --http2"
    ]
  }
}
