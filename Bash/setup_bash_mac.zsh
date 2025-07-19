#!/bin/zsh

# Check if Homebrew Bash is installed
if ! command -v /opt/homebrew/bin/bash &>/dev/null; then
    echo "Installing Bash via Homebrew..."
    brew install bash
else
    echo "Homebrew Bash is already installed."
fi

# Add Homebrew Bash to /etc/shells if not already present
if ! grep -q "/opt/homebrew/bin/bash" /etc/shells; then
    echo "Adding /opt/homebrew/bin/bash to /etc/shells (sudo required)..."
    echo "/opt/homebrew/bin/bash" | sudo tee -a /etc/shells > /dev/null
else
    echo "/opt/homebrew/bin/bash already listed in /etc/shells."
fi

# Set Bash as default login shell for the current user
current_shell=$(dscl . -read ~/ UserShell | awk '{print $2}')
if [[ "$current_shell" != "/opt/homebrew/bin/bash" ]]; then
    echo "Changing login shell to /opt/homebrew/bin/bash..."
    chsh -s /opt/homebrew/bin/bash
else
    echo "Login shell is already set to Homebrew Bash."
fi

# Create or overwrite ~/.bash_profile
echo "Creating ~/.bash_profile..."
cat <<'EOF' > ~/.bash_profile
# Include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export BASH_SILENCE_DEPRECATION_WARNING=1
EOF

# Suppress "Last login" message
echo "Creating ~/.hushlogin to suppress login message..."
touch ~/.hushlogin

echo "Done! Restart your terminal to start using Bash."

