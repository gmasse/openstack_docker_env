#cloud-config

packages: ['apt-transport-https', 'ca-certificates', 'curl', 'software-properties-common', 'pastebinit', 'docker-ce', 'zsh']
package_update: true
#package_upgrade: true
package_reboot_if_required: false
apt:
    preserve_sources_list: true
    sources:
        docker-ce.list:
            source: deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable
            keyid: 0EBFCD88
write_files:
  - path: /etc/systemd/network/30-ens3.network
    permissions: '0644'
    content: |
      [Match]
      Name=ens3
      [Network]
      DHCP=ipv4
  - content: |
      ${base64encode(file("${customterm_file}"))}
    encoding: b64
#    owner: ubuntu:ubuntu
# bug https://bugs.launchpad.net/cloud-init/+bug/1486113
    path: /home/ubuntu/customterm.sh
    permissions: '0755'
  - content: |
      ${base64encode(file("${zshrc_file}"))}
    encoding: b64
    path: /home/ubuntu/zshrc
    permissions: '0644'
  - content: |
      ${base64encode(file("${vimrc_file}"))}
    encoding: b64
    path: /home/ubuntu/vimrc
    permissions: '0644'
runcmd:
  - chown ubuntu:ubuntu /home/ubuntu/
  - chown ubuntu:ubuntu /home/ubuntu/customterm.sh /home/ubuntu/zshrc /home/ubuntu/vimrc
  - su ubuntu -c '/home/ubuntu/customterm.sh'
  - mv -f /home/ubuntu/zshrc /home/ubuntu/.zshrc
  - mv -f /home/ubuntu/vimrc /home/ubuntu/.vimrc
  - chsh -s $(which zsh) ubuntu
