#cloud-config

packages: ['apt-transport-https', 'ca-certificates', 'curl', 'software-properties-common', 'docker-ce', 'docker-ce-cli', 'containerd.io', 'docker-compose', 'build-essential', 'zsh']
package_update: true
package_upgrade: false
package_reboot_if_required: false
apt:
    preserve_sources_list: true
    sources:
        docker-ce.list:
            source: deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable
            keyid: 0EBFCD88
system_info:
    default_user:
        name: "ubuntu"
        shell: /bin/zsh
runcmd:
  - update-alternatives --set editor /usr/bin/vim.basic
  - runuser -l ubuntu -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/gmasse/openstack_docker_env/master/all_in_one.sh)"'
