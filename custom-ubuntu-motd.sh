#!/bin/sh

###################################################################################################################
# To run this script (as root):
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/gmasse/openstack_docker_env/master/custom-ubuntu-motd.sh)"
#

# Remove help and Ubuntu(R) news
chmod -x /etc/update-motd.d/10-help-text /etc/update-motd.d/50-motd-news /etc/update-motd.d/80-livepatch

# Install FIGlet
apt-get -y update
apt-get -y install --no-install-recommends figlet toilet-fonts

# Fancy colors and banner
reset="\\\e[0m"
yellow="\\\e[33m"
orange="\\\e[91m"
grey="\\\e[92m"
red="\\\e[31m"
printf "#!/bin/sh\n\nprintf \"$yellow\"\n" > /etc/update-motd.d/00-000-color-solarized
printf "#!/bin/sh\n\nprintf \"$reset\"\n"  > /etc/update-motd.d/00-zzz-color-solarized
printf "#!/bin/sh\n\nprintf \"$orange\"\nhostname | figlet -f mono9\nprintf \"$reset\"\n" > /etc/update-motd.d/05-hostname
printf "#!/bin/sh\n\nprintf \"$grey\"\n"   > /etc/update-motd.d/50-000-color-solarized
printf "#!/bin/sh\n\nprintf \"$reset\"\n"  > /etc/update-motd.d/50-zzz-color-solarized
printf "#!/bin/sh\n\nprintf \"$red\"\n"    > /etc/update-motd.d/98-000-color-solarized
printf "#!/bin/sh\n\nprintf \"$reset\"\n"  > /etc/update-motd.d/98-zzz-color-solarized

chmod +x /etc/update-motd.d/00-000-color-solarized /etc/update-motd.d/00-zzz-color-solarized /etc/update-motd.d/05-hostname /etc/update-motd.d/50-000-color-solarized /etc/update-motd.d/50-zzz-color-solarized /etc/update-motd.d/98-000-color-solarized /etc/update-motd.d/98-zzz-color-solarized
