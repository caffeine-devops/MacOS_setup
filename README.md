# MacOS_setup

This repository will cover details on how I went ahead with setting up my Mac for development.

**Note that I am mainly covering from the POV of packages and tools. Not system settings**

**GO THROUGH THE CONFIG FILE OR SCRIPT BEFORE USING IT**

## Install Homebrew

Homebrew is a package manager for macOS (and Linux if I am not wrong). It lets you install and manage software easily from the CLI.
Run the elow commands in your terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

When you run this command, it will print some directions for updating your shell's config. YOU NEED TO FOLLOW THOSE DIRECTIONS!!!

You need to update your shell's config file (~/.bashrc or ~/.zshrc) and add this:

```bash
eval "$(<Homebrew prefix path>/bin/brew shellenv)"
# in my case eval "$(/opt/homebrew/bin/brew shellenv)"
```

With this you have homebrew installed. you can verify it by running

```bash
brew --version
```

### Installing essential applications using Homebrew

Homebrew has 2 main types of applications that you can download.

- **Formulae** -> *which are CLI apps*
- **Casks** -> *Which are GUI apps*

Now you need to install any applications you need which are available on brew.
I start with downloading the following

```bash
#For formulae
brew install autojump bash-completion fastfetch fzf glow htop multitail node neovim ripgrep starship tree

#For Casks
brew install --cask brave-browser font-fira-code-nerd-font ghostty

#Create brewfile for future reference
# brew bundle dump --describe
# install from it
# brew bundle --file=/path/to/brewfile
```

## Ghostty

Ghostty is my prefered terminal emulator and I have been using it since it's launch in Linux. **Installation is already done by brew**
So now I am going to use the config file that I am comfortable using.

macOS-specific path was:
    *~/Library/Application Support/com.mitchellh.ghostty/*
Add the contents from my ghostty directory in this repo to that location.

p.s., I heared that it should also work on path
    *$XDG_CONFIG_HOME/ghostty/*
but I haven't tried it.

## Switching to Bash

By default macOS uses **zsh** as the default shell. But I prefer using **bash**.
Why bash?
The simple answer is that it is more commonly used in most servers and systems. As someone who works in DevOps/SRE, I interact a lot with bash. So I switched.

### Bash Installation

I already had bash installed, which I confirmed by running the below command (you can too)

```bash
ls /bin/ | grep bash
```

If you see bash as the output, then congratulations! you have bash pre-installed.
Don't worry if the above command didn't give you any output. just follow the below steps...

```bash
brew install bash

#to make new bash usable as login shell:
sudo vim /etc/shells

#add the below line to the list
/opt/homebrew/bin/bash
```

## Change the default shell to bash

```bash
#if using macOS's default bash:
chsh -s /bin/bash

#if using homebrew version:

chsh -s /opt/homebrew/bin/bash
```

After this, restart the terminal and run

```bash
echo $SHELL
```

the output confirmed that my shell is changed to bash

### Fix the zsh warning

Even after switching, Terminal might still show a warning everytime which goes like

```text
The default interactive shell is now zsh. To update your account to use zsh, please run chsh -s /bin/zsh.
```

This won't go away unless `~/.bashrc` is sourced correctly. 
To fix this, create a `~/.bash_profile` file with this content:

```bash
# Include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export BASH_SILENCE_DEPRECATION_WARNING=1
```

**why we need this?**

- `~/.bashrc`: Runs in non-login interactive shells.
- `~/.bash_profile`: Runs in login shells

By sourcing the `~/.bashrc` from `~/.bash_profile`, both environments stay consistent and the zsh warning goes away.

### Remove "Last Login" Message

Each time you open the terminal, you might still see something like:

```text
Last login: Fri Jul 18 18:55:44 on ttys001
```

To suppress this:

```bash
touch ~/.hushlogin
```

### Note

Even if you change your shell in:

- System Settings -> Users & Groups ... or
- Terminal > Settings > Shell,

You'll still need to do the steps above to make everything actually work cleanly with bash
*or run the script in bash directory and let it do things for yourself*

***I have attached my .bashrc and .bash_profile for mac in bash directory in this repo***

## Starship

Starship is the minimal (depending on your config), fast and extremely customizable prompt for any shell. You can make it look super sleek and minimal or super informative. my current config makes it look pretty much informative and descriptive and not minimal. (will improve it down the line.)

**installed starship using brew**

To have your custom prompt, you can edit (create if not present) the file `~/.config/starship.toml`

***I have added my starship.toml file in this repo's Starship directory***

## NeoVim

I use config inspired from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) for my neovim.
I encourage you refer it's documentation for installation and setup.

***I am going to add my nvim config in NeoVim Directory in this repo***
