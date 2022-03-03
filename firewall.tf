resource "digitalocean_firewall" "default" {
  name = "AllowSSHFromApproved"

  droplet_ids = [digitalocean_droplet.droplet-1.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = [var.ssh_src_ipv4]
  }
}
