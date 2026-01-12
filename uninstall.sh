#!/bin/bash

# Crail Paper Theme Uninstaller

set -e

# Colors
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}Uninstalling Crail Paper Theme components...${NC}"

# 1. Icons
ICON_DIR="$HOME/.local/share/icons/Crail-Paper"
if [ -d "$ICON_DIR" ]; then
    echo "Removing Icons..."
    rm -rf "$ICON_DIR"
fi

# 2. Themes
THEME_DIR="$HOME/.local/share/cosmic/themes"
echo "Removing Theme files..."
rm -f "$THEME_DIR/Crail_Paper_Solid.ron"
rm -f "$THEME_DIR/Crail_Paper_Frosted.ron"
rm -f "$THEME_DIR/Crail_Paper_Glass.ron"
rm -f "$THEME_DIR/Crail_Paper_Accent.ron"

# 3. Terminal Profile
TERM_PROFILE="$HOME/.config/cosmic/com.system76.CosmicTerm/v1/profiles/Crail_Paper_Terminal.ron"
TERM_CONFIG="$HOME/.config/cosmic/com.system76.CosmicTerm/v1/config.ron"

if [ -f "$TERM_PROFILE" ]; then
    echo "Removing Terminal Profile..."
    rm -f "$TERM_PROFILE"
fi

# Revert Terminal Config
if [ -f "$TERM_CONFIG" ]; then
    echo "Reverting Terminal active profile..."
    sed -i '/Crail_Paper_Terminal/d' "$TERM_CONFIG"
fi

# 4. Wallpaper
WALL_DIR="$HOME/.local/share/backgrounds/cosmic"
echo "Removing Wallpaper..."
rm -f "$WALL_DIR/crail-paper-wallpaper.png"

# 5. GTK Override
GTK_CSS="$HOME/.config/gtk-4.0/gtk.css"
if [ -f "$GTK_CSS" ]; then
    echo "Removing GTK 4.0 override..."
    rm -f "$GTK_CSS"
fi

# Update Cache
if command -v gtk-update-icon-cache &> /dev/null; then
    echo "Updating icon cache..."
    gtk-update-icon-cache -f "$HOME/.local/share/icons" 2>/dev/null || true
fi

echo -e "${GREEN}Uninstallation Complete.${NC}"