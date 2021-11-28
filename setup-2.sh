#!/bin/bash
pressanykey(){
	read -n1 -p "${txtpressanykey}"
}

txtpressanykey="Press any key to continue."
txtusername="Create New User"
archsethostname(){
	hostname=$(whiptail --backtitle "${apptitle}" --title "${txtsethostname}" --inputbox "" 0 0 "archlinux" 3>&1 1>&2 2>&3)
	if [ "$?" = "0" ]; then
		clear
		echo "echo \"${hostname}\" > /etc/hostname"
		echo "${hostname}" > /etc/hostname
		pressanykey
	fi
}

archsethostname

archusername(){
  username=$(whiptail --backtitle "${apptitle}" --title "${txtusername}" --inputbox "" 0 0  "dcos" 3>&1 1>&2 2>&3)
  if [ $(whoami) = "root" ]; then
         clear
         useradd -m -G wheel,libvirt -s /bin/bash $username
         passwd $username
	 cp -R /root/dcos /home/$username/
         chown -R $username: /home/$username/dcos
  else
	echo "You are already a user proceed with aur installs"
  fi
}

archusername 



echo -e "\nINSTALLING AUR SOFTWARE\n"
# You can solve users running this script as root with this and then doing the same for the next for statement. 
# However I will leave this up to you.

echo "CLONING: YAY"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd ~
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
touch "$HOME/.cache/zshhistory"


PKGS=(
'autojump'
'awesome-terminal-fonts'
'dxvk-bin' # DXVK DirectX to Vulcan
'lightly-git'
'lightlyshaders-git'
'multicolor-sddm-theme'
'nerd-fonts-fira-code'
'nordic-darker-standard-buttons-theme'
'nordic-darker-theme'
'nordic-kde-git'
'nerd-fonts-jetbrains-mono'
'nordic-theme'
'nerd-fonts-ubuntu-mono'
'noto-fonts-emoji'
'papirus-icon-theme'
'ocs-url' # install packages from websites
'sddm-nordic-theme-git'
'ttf-droid'
'ttf-hack'
'ttf-meslo' # Nerdfont package
'ttf-roboto'
)
