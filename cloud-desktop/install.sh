#!/bin/zsh

BACKUP_FILE_POSTFIX='_bak'

function backup_file() {
    BACKUP_FILE_PATH="$1$BACKUP_FILE_POSTFIX"
    if [[ -f "$1" ]]; then
        echo "File $1 exists, backing up before overwriting..."
        mv -n $1 $BACKUP_FILE_PATH
    fi
    echo "Backed up the file $1 to $BACKUP_FILE_PATH"
}

# Installs scripts from this package into your local env
# Backups all scripts before editing

# install oh-my-zsh if not installed
if [[ ! -d ~/.oh-my-zsh ]]; then
    cd ~
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# install powerlevel10k if not installed
if [[ ! -d ~/powerlevel10k ]]; then
    echo "Installing powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# install fzf if not installed
if [[ ! $(type fzf >/dev/null 2>&1) && ! -d ~/.fzf ]]; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

# install neovim if not installed
if [[ ! -d ~/nvim ]]; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    ./squashfs-root/AppRun --version

    # Optional: exposing nvim globally.
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

    # cleanup
    rm -rf ./squashfs-root
    rm -rf ./nvim.appimage
fi

# install nvim config
if [[ ! -d ~/nvim ]]; then
    # install repo files
    git clone https://github.com/noahlozevski/nvim.git ~/nvim
fi

# install brew
if [[ ! -d /home/linuxbrew ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install asdf if not already installed
if [[ ! -d ~/.asdf ]]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf

    # add node plugin
    asdf plugin add nodejs

    # add plugin for aliasing node to names (version agnostic)
    asdf plugin add alias https://github.com/jtzero/asdf-alias.git

    # install pre-reqs to compile
    sudo yum install -y gcc10 gcc10-c++ ninja-build

    # install / update nodejs 18, force compiling, since AL2 doesnt include the right deps
    ASDF_NODEJS_VERBOSE_INSTALL=1 \
        ASDF_NODEJS_FORCE_COMPILE=1 \
        CXX=gcc10-g++ \
        NINJA=ninja-build CONFIGURE_OPTS=--ninja \
        asdf install nodejs latest:18

    asdf alias nodejs lts-hydrogen 18.16.0
    asdf global nodejs lts-hydrogen
    asdf local nodejs lts-hydrogen
fi

# Backup zshrc
backup_file ~/.zshrc

# Replace zshrc
cp ./.scripts/.zshrc ~/.zshrc

# Backup ~/.scripts/zshrc dir
backup_file ~/.scripts/variables
backup_file ~/.scripts/aliases
backup_file ~/.scripts/functions
backup_file ~/.scripts/languages
backup_file ~/.scripts/root

# Overwrite ~/.scripts/zshrc dir
cp -r ./.scripts/zshrc ~/.scripts

backup_file ~/.zshenv
cp ./.scripts/.zshenv ~/.zshenv

backup_file ~/.p10k.zsh
cp ./.scripts/.p10k.zsh ~/.p10k.zsh

backup_file ~/.tmux.conf
cp ./.scripts/.tmux.conf ~/.tmux.conf

backup_file ~/tmux-sessionizer.sh
cp ./.scripts/tmux-sessionizer.sh ~/.scripts/tmux-sessionizer.sh


echo "Done installing!"

