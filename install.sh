#!/bin/bash

# Anthropic Claude Theme Installer for COSMIC DE

set -e # Exit on error

THEME_NAME="Anthropic-Claude"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ICON_DEST="$HOME/.local/share/icons/$THEME_NAME"
THEME_DEST="$HOME/.config/cosmic/themes" # Attempting standard config path, fallback to local share
THEME_FILE="Anthropic_Claude_*.ron"

# Colors
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${ORANGE}Installing Anthropic Claude Theme components...${NC}"

# --- 1. Install Icons ---
echo "Installing Icon Theme..."
if [ -d "$ICON_DEST" ]; then
    rm -rf "$ICON_DEST"
fi
mkdir -p "$ICON_DEST"
cp -r "$SOURCE_DIR/icons/"* "$ICON_DEST/"

# Update Icon Cache
if command -v gtk-update-icon-cache &> /dev/null; then
    echo "Updating icon cache..."
    gtk-update-icon-cache -f "$ICON_DEST"
fi

echo -e "${GREEN}Icons installed successfully.${NC}"

# --- 2. Install Theme File ---
# COSMIC doesn't always auto-discover ron files in a specific folder without import,
# but we'll try to place it in a sensible user directory for easy finding.
# We'll also try the ~/.config/cosmic/themes path if it exists or create it.

echo "Preparing Theme File..."
# Create a user themes directory if it doesn't exist (Standard XDG location for some apps)
mkdir -p "$HOME/.local/share/cosmic/themes"
cp $SOURCE_DIR/$THEME_FILE "$HOME/.local/share/cosmic/themes/"

# Also copy to Documents for visibility if easy access is needed, or just keep it in the share folder.
# Let's just stick to printing the path clearly.

echo -e "${GREEN}Theme files copied to: $HOME/.local/share/cosmic/themes/${NC}"

# --- 3. Final Instructions ---
echo ""
echo -e "${ORANGE}==========================================${NC}"
echo -e "${GREEN}INSTALLATION COMPLETE${NC}"
echo -e "${ORANGE}==========================================${NC}"
echo ""
echo "To apply the changes:"
echo ""
echo "1. Open ${ORANGE}COSMIC Settings${NC} -> ${ORANGE}Desktop${NC} -> ${ORANGE}Appearance${NC}."
echo "2. Under 'Icons', select ${GREEN}$THEME_NAME${NC}."
echo "3. Under 'Theme', click ${ORANGE}Import${NC} and navigate to:"
echo "   ${GREEN}$HOME/.local/share/cosmic/themes/${NC}"
echo "   Select either 'Anthropic_Claude_Inspired.ron' (Solid) or 'Anthropic_Claude_Frosted.ron' (Blurred)"
echo ""
echo "Enjoy your new desktop!"
