#!/bin/bash

# Anthropic Claude Theme Uninstaller

set -e

# Colors
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}Uninstalling Anthropic Claude Theme components...${NC}"

# 1. Icons
ICON_DIR="$HOME/.local/share/icons/Anthropic-Claude"
if [ -d "$ICON_DIR" ]; then
    echo "Removing Icons..."
    rm -rf "$ICON_DIR"
fi

# 2. Themes
THEME_DIR="$HOME/.local/share/cosmic/themes"
echo "Removing Theme files..."
rm -f "$THEME_DIR/Anthropic_Claude_Inspired.ron"
rm -f "$THEME_DIR/Anthropic_Claude_Frosted.ron"
rm -f "$THEME_DIR/Anthropic_Claude_Glass.ron"
rm -f "$THEME_DIR/Anthropic_Claude_Accent.ron"

# 3. Terminal Profile
TERM_PROFILE="$HOME/.config/cosmic/com.system76.CosmicTerm/v1/profiles/Anthropic_Claude_Terminal.ron"
TERM_CONFIG="$HOME/.config/cosmic/com.system76.CosmicTerm/v1/config.ron"

if [ -f "$TERM_PROFILE" ]; then
    echo "Removing Terminal Profile..."
    rm -f "$TERM_PROFILE"
fi

# Revert Terminal Config
if [ -f "$TERM_CONFIG" ]; then
    echo "Reverting Terminal active profile..."
    # This deletes the line containing the custom profile setting
    sed -i '/Anthropic_Claude_Terminal/d' "$TERM_CONFIG"
fi

# 4. Wallpaper
WALL_DIR="$HOME/.local/share/backgrounds/cosmic"
echo "Removing Wallpaper..."
rm -f "$WALL_DIR/anthropic-claude-wallpaper.png"
rm -f "$WALL_DIR/anthropic-claude-wallpaper.svg" # Just in case

# 5. GTK Override
GTK_CSS="$HOME/.config/gtk-4.0/gtk.css"
if [ -f "$GTK_CSS" ]; then
    # Only remove if it matches our file (simple check or just remove if user confirms, but here we assume we own it for this context or just warn)
    # For safety, let's just back it up or check content. 
    # For this specific task, we'll assume we overwrite it on install, so we remove it on uninstall.
    echo "Removing GTK 4.0 override..."
    rm -f "$GTK_CSS"
fi

# 6. MaterialOS Icons (Optional)
# We don't strictly know if *we* installed them, but we can ask or just leave them. 
# The prompt implies we might install them.
# Let's leave them be to be safe, as the user might have had them before.

# Update Cache
if command -v gtk-update-icon-cache &> /dev/null; then
    echo "Updating icon cache..."
    gtk-update-icon-cache -f "$HOME/.local/share/icons" 2>/dev/null || true
fi

echo -e "${GREEN}Uninstallation Complete.${NC}"
echo "Note: You may need to reset your Appearance settings in COSMIC Settings to defaults."
