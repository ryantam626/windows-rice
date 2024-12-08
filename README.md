# Install intellij idea

Manually downloading from web myself.

# Install fonts

Download this, extract and move into `C:\Windows\Fonts` manually.

https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip

# Kmonad

## Install git + stack + ghcup

1. git
2. stack, ghcup for kmonad compilation
```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex
scoop install git stack ghcup
```

## Install ghc

```powershell
ghcup install ghc
```

## Compile
```bash
mkdir -p /c/sources/
cd /c/sources
git clone git@github.com:ryantam626/kmonad.git
cd kmonad
stack install
```

## Get ssh key from somewhere

ssh-keygen or just reuse some key.

```bash
mkdir ~/.ssh
vim ~/.ssh/id_ed25519
vim ~/.ssh/id_ed25519.pub
chmod 600 ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
```

## Clone this repo

```bash
cd /c/sources
git clone git@github.com:ryantam626/windows-rice.git
```

## Making shortcut for program

```powershell
cmd.exe /k  kmonad.exe C:\sources\windows-rice\windows-dotfiles\kmonad\regular-keyboard.kbd -l info
```

# Mado

## Install pyenv

```powershell
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
```

## Install python

```bash
pyenv update
pyenv install 3.11.9
pyenv global 3.11.9
```

## Install poetry
```bash
curl -sSL https://install.python-poetry.org | python3 -
```

## Clone

```bash
cd /c/sources
git clone git@github.com:ryantam626/mado.git
cd mado/mado-py
$HOME/AppData/Roaming/Python/Scripts/poetry.exe shell
$HOME/AppData/Roaming/Python/Scripts/poetry.exe install
```

## Making shortcut for program

JUST AN EXAMPLE - you might need to fix the path.

```powershell
C:\Windows\System32\cmd.exe /k C:\Users\ryant\AppData\Local\pypoetry\Cache\virtualenvs\mado-4nSdn9uw-py3.11\Scripts\mado-run.cmd
```


# Window terminal

Get it from [https://aka.ms/terminal](https://aka.ms/terminal).

# Install WSL Ubuntu

```powershell
wsl.exe --install -d Ubuntu-24.04
```

Reboot afterwards.

# Install Nix on Ubuntu

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

Then restart WSL shell to pick it up in shell.

## Enable flake support
```bash
nixconf=~/.config/nix/nix.conf
mkdir -p $(dirname $nixconf)
echo "experimental-features = nix-command flakes" > $nixconf
```

## Install Home Manager

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

# Use home manager to configure ubuntu

## Clone ssh keys over from windows

```bash
windows_user_name=ryant
windows_ssh_dir=/mnt/c/Users/$windows_user_name/.ssh
cp -r $windows_ssh_dir ~
sudo chown $USER ~/.ssh/id*
sudo chown 600 ~/.ssh/id*
```

## Clone this repo

```bash
git clone git@github.com:ryantam626/windows-rice.git
```

## Switch home manager config

```bash
cd windows-rice/ubuntu-home-manager
home-manager switch --flake .#rtam
```

# Install some additional softwares

```bash
~/windows-rice/installers/docker.sh
~/windows-rice/installers/pyenv.sh
```

## Manually switch login shell

home manager cannot manage this for us.

```bash
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s "$(command -v zsh)" "${USER}"
```

Restart shell after.

# Set windows terminal config

See windows-dotfiles/windows-terminal.json and copy and paste that into terminal config.

# Other manual configuration

See [imgs dir](./imgs).

## Ideavimrc on windows

Copy and paste the `.ideavimrc` from WSL root to windows root.
