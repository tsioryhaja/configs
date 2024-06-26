# configs

This is my development configuration file. It's mostly for Vim/Neovim.
I use it for Javascript/Typescript, Angular, Python, C/C++, GO and Godot Engine development.
It is actually for a windows environment only, but I will add my linux environment later.

# Config Neovim

First you need to install "wbthomason/packer.nvim".
I do that with git but feel free to do it the way you want.

``` shell
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
```

Next, you need to clone the repo anywhere you want it on your computer.

``` shell
git clone https://github.com/tsioryhaja/configs.git
```

After that, create a symbolic link to the nvim folder in the project in "~\AppData\Local\nvim".

``` shell
cmd.exe /c mklink /D "$env:LOCALAPPDATA\nvim" "D:\configs\nvim"
```

Then open neovim anywhere and install packages with packer

``` shell
:PackerInstall
```

For typescript you need to install the language server.

``` shell
npm install -g typescript typescript-language-server@0.10.1
```

I actually use "Telescope" with ripgrep so you need to install "BurntSushi/ripgrep" and add it to you "path".

# Config Oh-my-posh
The Oh-my-posh config is inside the ohmyposh-configs.json. It's a modified version of the amro theme.
In windows you need to add this inside the "C:\Users\{username}\OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" file:

```shell
Import-Module oh-my-posh
oh-my-posh init pwsh --config "E:/data/configs/ohmyposh-configs.json" | Invoke-Expression
Function Files {Invoke-Expression "ls -name -r -dir | fzf | cd"}
```
