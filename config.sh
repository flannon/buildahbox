#!/usr/bin/env bash

#git clone https://github.com/flannon/dotfiles-fedora-sb ${HOME}/.dotfiles 
#git clone https://github.com/flannon/dotfiles-fedora-sb /home/terrance/.dotfiles 
chmod 777 /dotfiles/ansible/roles
/dotfiles/ansible-run.sh $USER

/usr/bin/touch /var/tmp/cmd-output-

touch /var/tmp/lubdub-out

while :
do 
  echo lubdub >> /var/tmp/lubdub-out
  sleep 5
done