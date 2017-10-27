#! /usr/bin/env bash
# Gets the system type so we can run separate instructions for Mac vs Linux
uname="$(uname -s)"
echo "Detected $uname system"

# TODO: Symbolic link between .vimrc in this directory and ~/.vimrc
# Get the directory of this script: https://stackoverflow.com/a/246128
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Check if ~/.vimrc is already a symlink
if [ -h "$HOME/.vimrc" ];
then
  if [ "$(readlink $HOME/.vimrc)" = "$script_dir/.vimrc" ];
  then
    echo "Symlink already exists between versioned .vimrc and ~/.vimrc"
  else
    echo "Errror: ~/.vimrc is symlinked to an unknown file. Check this and remove it, then try again."
    exit
  fi
else
  if [ -f "$HOME/.vimrc" ];
  then
    echo "Existing ~/.vimrc file found. Backing it up to ~/.vimrc.backup"
    mv $HOME/.vimrc $HOME/.vimrc.backup
  fi

  echo "Symlinking versioned .vimrc to ~/.vimrc"
  cd $HOME && ln -s $script_dir/.vimrc .
fi

# Grab the vim version number
vim_version="$(vim --version | head -1 |cut -d ' ' -f 5)"
# If vim version is lower than 8.0, need to upgrade
# TODO: Current mechanism is to use `eval` to evaluate this. This can be unsafe.
vim_upgrade_needed='[[ "$(echo "$vim_version < 8.0" | bc)" -eq 1 ]]'

if [ "$uname" == "Darwin" ];
then
  bash_pref="$HOME/.bash_profile"
  if eval $vim_upgrade_needed 
  then
    echo "Upgrading vim to >=8.0 with Homebrew"
    # To ensure that we have vim 8 installed for advanced features required by some
    # Vim plugins
    brew install vim --with-override-system-vi
  else
    echo "vim >=8.0 already installed"
  fi
elif [ "$uname" == "Linux" ];
then
  bash_pref="$HOME/.bashrc"
  if eval $vim_upgrade_needed
  then
    # TODO: Need an equivalent command for Linux
    echo "Error: $uname has no commands for installing vim 8"
    exit 
  else
    echo "vim >=8.0 already installed"
  fi
else
  echo "Error: Unrecognized system type $uname"
  exit
fi

vundle_install_dir="$HOME/.vim/bundle/Vundle.vim"
# Only execute the below if there isn't already something at the destination
if [ ! -d "$vundle_install_dir" ];
then
  echo "Installing Vundle"
  # Download Vundle for Vim plugins
  git clone https://github.com/VundleVim/Vundle.vim.git $vundle_install_dir 
else
  echo "Vundle is already installed"
fi

echo "Installing vim plugins"
# Run all of the plugin installs from newly installed .vimrc
vim +PluginInstall +qall

echo "Done! Start a new terminal session to ensure all changes take effect."
