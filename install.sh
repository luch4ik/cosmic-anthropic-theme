#!/bin/bash

# Crail Paper Theme Installer for COSMIC DE

set -e # Exit on error

THEME_NAME="Crail-Paper"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ICON_DEST="$HOME/.local/share/icons/$THEME_NAME"
THEME_DEST="$HOME/.config/cosmic/themes"
THEME_FILE="Crail_Paper_*.ron"

# Colors
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

# Check for existing install
EXISTING_THEME="$HOME/.local/share/cosmic/themes/Crail_Paper_Solid.ron"
if [ -f "$EXISTING_THEME" ]; then
    echo -e "${ORANGE}Existing installation detected.${NC}"
    read -p "Do you want to uninstall the existing theme and start fresh? (Y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        if [ -f "$SOURCE_DIR/uninstall.sh" ]; then
            echo "Running uninstaller..."
            chmod +x "$SOURCE_DIR/uninstall.sh"
            "$SOURCE_DIR/uninstall.sh"
        else
            echo "Uninstall script not found. Proceeding with overwrite."
        fi
    else
        echo "Proceeding with update (files will be overwritten)..."
    fi
fi

echo -e "${ORANGE}Installing Crail Paper Theme components...${NC}"

# --- 1. Install Icons ---
echo ""
read -p "Install Crail Paper Icon Theme? (Y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
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
else
    echo "Skipping icons."
fi

# --- 2. Install Theme Files ---
echo "Preparing Theme Files..."
mkdir -p "$HOME/.local/share/cosmic/themes"
cp $SOURCE_DIR/$THEME_FILE "$HOME/.local/share/cosmic/themes/"

echo -e "${GREEN}Theme files copied to: $HOME/.local/share/cosmic/themes/${NC}"

# --- 3. Install Terminal Profile ---
echo "Installing Terminal Profile..."
TERM_CONFIG_DIR="$HOME/.config/cosmic/com.system76.CosmicTerm/v1"
TERM_PROFILES_DIR="$TERM_CONFIG_DIR/profiles"
mkdir -p "$TERM_PROFILES_DIR"

cp "$SOURCE_DIR/Crail_Paper_Terminal.ron" "$TERM_PROFILES_DIR/"

CONFIG_FILE="$TERM_CONFIG_DIR/config.ron"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating new Terminal config..."
    cat <<EOF > "$CONFIG_FILE"
(
    font_size: 11,
    active_profile: Custom("Crail_Paper_Terminal"),
)
EOF
else
    echo "Updating existing Terminal config..."
    if grep -q "active_profile:" "$CONFIG_FILE"; then
        sed -i 's/active_profile: .*/active_profile: Custom("Crail_Paper_Terminal"),/' "$CONFIG_FILE"
    else
        echo "Could not automatically set active profile. Please select 'Crail Paper' in Terminal settings."
    fi
fi

echo -e "${GREEN}Terminal profile installed and configured.${NC}"

# --- 4. Install Extras ---
echo "Installing Extras..."

# GTK Theme Override
GTK_DEST="$HOME/.config/gtk-4.0"
mkdir -p "$GTK_DEST"
cp "$SOURCE_DIR/extras/gtk/gtk.css" "$GTK_DEST/"
echo -e "${GREEN}GTK 4.0 override installed.${NC}"

# Wallpaper
echo ""
read -p "Install Theme Wallpaper? (Y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    WALL_DEST="$HOME/.local/share/backgrounds/cosmic"
    mkdir -p "$WALL_DEST"
    cp "$SOURCE_DIR/extras/wallpaper/anthropic-claude-wallpaper.png" "$WALL_DEST/"
    echo -e "${GREEN}Wallpaper installed.${NC}"
else
    echo "Skipping wallpaper."
fi

# --- 5. Optional: MaterialOS Icons ---
echo ""
echo -e "${ORANGE}Recommended: MaterialOS Linux Icon Pack${NC}"
echo "These icons perfectly complement the geometric style of this theme."
read -p "Do you want to download and install MaterialOS icons? (y/N) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Downloading MaterialOS icons..."
    TEMP_DIR=$(mktemp -d)
    curl -L "https://github.com/materialos/Linux-Icon-Pack/archive/refs/heads/master.zip" -o "$TEMP_DIR/MaterialOS.zip"
    unzip -q "$TEMP_DIR/MaterialOS.zip" -d "$TEMP_DIR"
    TARGET_ICON_DIR="$HOME/.local/share/icons/MaterialOS"
    if [ -d "$TARGET_ICON_DIR" ]; then
        rm -rf "$TARGET_ICON_DIR"
    fi
    mv "$TEMP_DIR/Linux-Icon-Pack-master" "$TARGET_ICON_DIR"
    rm -rf "$TEMP_DIR"
    echo -e "${GREEN}MaterialOS icons installed to $TARGET_ICON_DIR${NC}"
else
    echo "Skipping MaterialOS icons."
fi

# --- 6. Final Instructions ---
echo ""
echo -e "${ORANGE}==========================================${NC}"
echo -e "${GREEN}INSTALLATION COMPLETE${NC}"
echo -e "${ORANGE}==========================================${NC}"
echo ""
echo "To apply the changes:"
echo ""
echo -e "1. Open ${ORANGE}COSMIC Settings${NC} -> ${ORANGE}Desktop${NC} -> ${ORANGE}Appearance${NC}."
echo -e "2. Under 'Icons', select ${GREEN}MaterialOS${NC} (Recommended) or ${GREEN}$THEME_NAME${NC}."
echo -e "3. Under 'Theme', click ${ORANGE}Import${NC} and navigate to:"
echo -e "   ${GREEN}$HOME/.local/share/cosmic/themes/${NC}"
echo "   Select 'Crail_Paper_Solid.ron', 'Crail_Paper_Frosted.ron', or 'Crail_Paper_Glass.ron'."
echo -e "4. Open ${ORANGE}COSMIC Terminal${NC} -> ${ORANGE}Settings${NC} -> ${ORANGE}Profiles${NC}."
echo -e "   Select ${GREEN}Crail Paper${NC}."
echo -e "5. Select the wallpaper in ${ORANGE}Desktop${NC} -> ${ORANGE}Wallpaper${NC}."
echo ""
echo "Enjoy your new desktop!"
