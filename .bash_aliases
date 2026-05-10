# Define the 'dots' alias (Always needed)
alias dots='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Direct IF checks for each command
if command -v batcat >/dev/null 2>&1; then alias bat="batcat"; fi
if command -v fdfind >/dev/null 2>&1; then alias fd="fdfind"; fi
if command -v matlab >/dev/null 2>&1; then alias m="matlab -nodesktop"; fi
if command -v cbonsai >/dev/null 2>&1; then alias clc="cbonsai -p"; fi

# COSMIC-specific scan for new config files
if [ -d "$HOME/.config/cosmic" ]; then
   alias cosmic-track="dots add --intent-to-add ~/.config/cosmic/"
   alias cosmic-scan="dots ls-files --others --exclude-standard -- .config/cosmic/"
fi

# Login visual
if command -v cbonsai >/dev/null 2>&1; then
    sleep 0.1; clc
fi
