# Load Homebrew environment if installed
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Source .bashrc for interactive setup
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

export BASH_SILENCE_DEPRECATION_WARNING=1
