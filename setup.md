# Install kmonad

This is a keyboard remapping manager software.

Useful even if you are using a keyboard that can be programmed with qmk/zmk, because some keys are just not mappable in them.

```powershell
# set required privileges to run scripts (required for scoop installer)
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
# install scoop (no admin rights required)
iwr -useb get.scoop.sh | iex
# install stack and git
scoop install stack git

# Make directory for cloning various utils later
mkdir C:\src

# Cloning my fork of kmonad
cd C:\src
git clone https://github.com/ryantam626/kmonad.git
cd kmonad


# compile KMonad (this will first download GHC and msys2, it takes a while)
# if the GHC download fails, then you would need to install it yourself\
# download it from https://www.haskell.org/ghc/download_ghc_9_4_8.html#windows64
# extract it, add to PATH env var, might need to reboot for the env var change to be picked up.
# then allow stack to use it by `stack config set system-ghc --global true`
stack build
stack install
```

# Clone this repo

Using git bash for now.

```bash
git clone git@github.com:ryantam626/windows-rice.git /c/src/windows-rice 
```

# Create KMonad shortcut

Copy and paste the following when creating the shortcut.
```
C:\Windows\System32\cmd.exe /k C:\Users\ryant\AppData\Roaming\local\bin\kmonad.exe C:\src\windows-rice\kmonad.kbd --log-level info
```

# Install python

```bash
scoop bucket add versions
scoop install versions/python312
```

# Install window manager

I have written my own window manager, at the time of writing this, it's in Python.

## Cloning repo
First clone the repo,
```bash
git clone git@github.com:ryantam626/mado.git /c/src/mado
```

## Getting poetry
Get poetry if not already installed, assumes you have a valid python installation already (might need to restart shell to pick up your installation)

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

Add C:\Users\ryant\AppData\Roaming\Python\Scripts to path via system settings, so it can pick up `poetry`.

## Install and configure window manager

Install and copy the path of the script to start the window manager. 
```bash
cd /c/src/mado/mado-py
poetry install
poetry shell
cygpath.exe -w $(which mado-run) | clip
```

Your clipboard should say something like 
```
C:\Users\ryant\AppData\Local\pypoetry\Cache\virtualenvs\mado-F4x-ECgr-py3.12\Scripts\mado-run
```

Create a desktop shortcut now if you want.

You would need to configure the window manager through editing `config.py`.

## Installing msys2

```bash
scoop install main/msys2
msys2 # to complete the install as suggested by stdout
```

## Installing tmux
```bash
pacman -S tmux
```

## Installing tmux plugins

TODO.

## Install zsh

```bash
pacman -S zsh
``` 

## Install oh-my-zsh

ZSH=/c/src/usr/oh-my-zsh chsh=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Install oh-my-zsh plugins
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

# Download the following fonts
https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf


## Install neovim
```bash
scoop install neovim	
```

## Misc.

# adding sys python scripts
add C:\Users\ryant\AppData\Roaming\Python\Scripts to path via system settings

need to comment this in in msys2.ini
MSYS2_PATH_TYPE=inherit
and add this for zsh shell
SHELL=/usr/bin/zsh

# TODO

Centralise dotfiles and use some symlink based apporach to enable dotfiles.