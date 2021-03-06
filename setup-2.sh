#!/bin/bash

echo -e "\nINSTALLING AUR SOFTWARE\n"
# You can solve users running this script as root with this and then doing the same for the next for statement. 
# However I will leave this up to you.
#sudo pacman -U /$username/dcos/yay.pkg.tar.zst --noconfirm 
 echo "CLONING: YAY"
 cd ~
 git clone "https://aur.archlinux.org/yay.git"
 cd ${HOME}/yay
 makepkg -si --noconfirm
 cd ~
 touch "$HOME/.cache/zshhistory"

echo -e "\nINSTALLING AUR SOFTWARE\n"
PKGS=(
'autojump'
'alacritty'
'awesome-terminal-fonts'
'dxvk-bin' # DXVK DirectX to Vulcan
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
'ttf-droid'
'ttf-hack'
'ttf-meslo' # Nerdfont package
'ttf-roboto'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done


export PATH=$PATH:~/.local/bin
cp -r /root/dcos/dotfiles/* $HOME/.config/
cp -r /root/dcos/.zshrc $HOME/
cp -r /root/dcos/dotfiles/* $HOME/.config/

#installing desktop environment
yay -S mintmenu brisk-menu --noconfirm --needed &&  pacman -S mate mate-extra --noconfirm --needed && dconf load /org/mate/ < $HOME/dcos/mate-backup


echo -e "\nDone!\n"
exit


