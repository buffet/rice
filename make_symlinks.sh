#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################
########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles/old             # old dotfiles backup directory
files="latexmkrc vim"    # list of files/folders to symlink in homedir

##########

# create dotfiles/old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles/old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

install_fish () {
# Test to see if fish is installed.  If it is:
if [ -f /bin/fish -o -f /usr/bin/fish ]; then
    # Clone my oh-my-fish repository from GitHub only if it isn't already present
    if [[ ! -d ~/.config/omf ]]; then
        curl -L https://get.oh-my.fish > install
        fish install --config=~/dotfiles/omf
        # fish install --path=~/.local/share/omf --config=~/dotfiles/omf
        rm install
    fi
    # Set the default shell to fish if it isn't currently set to fish
    if [[ ! $(echo $SHELL) == $(which fish) ]]; then
        chsh -s $(which fish)
    fi
else
    # If fish isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install fish and then recurse
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
            sudo yum install fish
            install_fish
        fi
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get install fish
            install_fish
        fi
    # If the platform is OS X, tell the user to install fish :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install fish, then re-run this script!"
        exit
    fi
fi
}

install_fish

