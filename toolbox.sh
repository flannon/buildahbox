#!/usr/bin/env bash

set -o errexit

#INSTALLDIR="/opt"
INSTALLDIR="/"
#UID=$(id -u)
GID=$(id -g)

# make the container
#container=$(buildah from --userns-uid-map-user $USER registry.fedoraproject.org/f31/fedora-toolbox:31)
container=$(buildah from registry.fedoraproject.org/f31/fedora-toolbox:31)
buildah config --label maintainer="Flannon Jackson <flannon@5eight5.com>" $container

mnt=$(buildah mount $container)

#buildah run $container -- sudo useradd -d /var/home/${USER} -u $UID --no-create-home $USER
#buildah run $container -- useradd -u $UID --no-create-home

echo "before user"
#buildah config --user ${USER}:${USER} $container
#buildah config --user 1000:1000 $container

echo "before run"
##buildah run $container -- dnf update -y
#buildah run $container -- dnf install -y ansible
#buildah run $container -- dnf clean all

#dnf install -y --installroot $mnt ansible gcc
dnf install -y --installroot $mnt ansible 
echo "after dnf"


##buildah run $container -- git clone https://github.com/flannon/dotfiles-fedora-sb dotfiles  
#buildah run $container -- git clone https://github.com/flannon/dotfiles-fedora-sb ${INSTALLDIR}/dotfiles  
git clone https://github.com/flannon/dotfiles-fedora-sb ${mnt}${INSTALLDIR}/dotfiles  
#[[ ! -d ${mnt}${INSTALLDIR}/dotfiles/roles ]] && \
#   mkdir ${mnt}${INSTALLDIR}/dotfiles/roles 

#chmod 777 ${mnt}${INSTALLDIR}dotfiles/roles

#chmod 777 ${mnt}${INSTALLDIR}/dotfiles/roles
#buildah run $container -- ${INSTALLDIR}/dotfiles/ansible-run.sh ${USER}

##buildah copy $container 'config.sh' ${INSTALLDIR}/setmeup.sh
cp ./config.sh ${mnt}${INSTALLDIR}/setmeup.sh
##buildah run $container -- chmod 755 ${INSTALLDIR}/setmeup.sh
#buildah copy $container 'config.sh' /setmeup.sh
#buildah run $container -- chmod 755 /setmeup.sh

#buildah run $container -- sh -c "cd ${INSTALLDIR}; ./ansibl-run $USER"

#buildah run $container -- sh -c "/usr/bin/ansible-galaxy install -r /dotfiles/ansible/requirements.yml"

#buildah config --cmd "/docker/ansible-run.sh $USER" $container
#buildah config --entrypoint '["/opt/dotfiles/ansible-run.sh", "$USER" ]' $container
#buildah config --cmd "/opt/dotfiles/ansible-run.sh $USER"  $container
#buildah config --cmd "/usr/bin/touch /home/${USER}/cmd-output-$$"  $container
#buildah config --cmd "/usr/bin/touch /cmd-output-$$"  $container
buildah config --cmd "/setmeup.sh" --env foo=bar --workingdir=/  $container

buildah config --author "flannon @ 5eight5.com" --label name=this-box $container

buildah commit $container thisbox