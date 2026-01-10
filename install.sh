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

# Check for existing install
EXISTING_THEME="$HOME/.local/share/cosmic/themes/Anthropic_Claude_Inspired.ron"
if [ -f "$EXISTING_THEME" ]; then
    echo -e "${ORANGE}Existing installation detected.${NC}"
    read -p "Do you want to uninstall the existing theme and start fresh? (Y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        if [ -f "$SOURCE_DIR/uninstall.sh" ]; then
            echo "Running uninstaller..."
            # Make sure it's executable
            chmod +x "$SOURCE_DIR/uninstall.sh"
            "$SOURCE_DIR/uninstall.sh"
        else
            echo "Uninstall script not found. Proceeding with overwrite."
        fi
    else
        echo "Proceeding with update (files will be overwritten)..."
    fi
fi

echo -e "${ORANGE}Installing Anthropic Claude Theme components...${NC}"

# --- 1. Install Icons ---
echo ""
read -p "Install Anthropic Claude Icon Theme (Official)? (Y/n) " -n 1 -r
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
    echo "Skipping Anthropic Claude icons."
fi

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

# --- 3. Install Terminal Profile ---
echo "Installing Terminal Profile..."
TERM_CONFIG_DIR="$HOME/.config/cosmic/com.system76.CosmicTerm/v1"
TERM_PROFILES_DIR="$TERM_CONFIG_DIR/profiles"
mkdir -p "$TERM_PROFILES_DIR"

# Copy the profile definition
cp "$SOURCE_DIR/Anthropic_Claude_Terminal.ron" "$TERM_PROFILES_DIR/"

# Attempt to set it as active by creating/updating the config.ron
# This is a basic overwrite/create if missing, or a sed replacement if simple.
# Since RON is structured, robust parsing is hard with bash, but we can try a simple config creation if it doesn't exist.

CONFIG_FILE="$TERM_CONFIG_DIR/config.ron"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating new Terminal config..."
    # Create a minimal config setting the profile
    cat <<EOF > "$CONFIG_FILE"
(
    font_size: 11,
    active_profile: Custom("Anthropic_Claude_Terminal"),
)
EOF
else
    echo "Updating existing Terminal config..."
    # Try to replace the active_profile line using sed. 
    # Use a temp file to avoid issues.
    if grep -q "active_profile:" "$CONFIG_FILE"; then
        sed -i 's/active_profile: .*/active_profile: Custom("Anthropic_Claude_Terminal"),/' "$CONFIG_FILE"
    else
        # Insert it at the beginning of the tuple if it's missing (a bit risky with simple sed, but usually safe for top-level keys)
        # Fallback: append it before the closing parenthesis?
        # Safest for now: Just warn the user if we can't cleanly set it.
        echo "Could not automatically set active profile. Please select 'Anthropic Claude' in Terminal settings."
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
read -p "Install Anthropic Claude Wallpaper? (Y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    WALL_DEST="$HOME/.local/share/backgrounds/cosmic"
    mkdir -p "$WALL_DEST"
    cp "$SOURCE_DIR/extras/wallpaper/anthropic-claude-wallpaper.png" "$WALL_DEST/"
    echo -e "${GREEN}Wallpaper (PNG) installed.${NC}"
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
    
    # Download master zip
    curl -L "https://github.com/materialos/Linux-Icon-Pack/archive/refs/heads/master.zip" -o "$TEMP_DIR/MaterialOS.zip"
    
    # Unzip
    unzip -q "$TEMP_DIR/MaterialOS.zip" -d "$TEMP_DIR"
    
    # Install
    TARGET_ICON_DIR="$HOME/.local/share/icons/MaterialOS"
    if [ -d "$TARGET_ICON_DIR" ]; then
        rm -rf "$TARGET_ICON_DIR"
    fi
    mv "$TEMP_DIR/Linux-Icon-Pack-master" "$TARGET_ICON_DIR"
    
    # Clean up
    rm -rf "$TEMP_DIR"
    
    echo -e "${GREEN}MaterialOS icons installed to $TARGET_ICON_DIR${NC}"
else
    echo "Skipping MaterialOS icons."
fi

# --- 6. Firefox Theme Helper ---
echo ""
echo -e "${ORANGE}Firefox Theme${NC}"
echo "Mozilla restricts automatic theme installation. It must be loaded manually."
read -p "Launch Firefox to install the theme now? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    FIREFOX_MANIFEST="$SOURCE_DIR/extras/firefox/manifest.json"

    echo -e "Launching Firefox to ${ORANGE}about:debugging${NC}..."
    if command -v firefox &> /dev/null; then
        nohup firefox "about:debugging#/runtime/this-firefox" >/dev/null 2>&1 &
    else
        echo -e "${RED}Firefox command not found.${NC} Please open Firefox manually."
    fi
    
    echo ""
    echo -e "${ORANGE}-------------------------------------------------------${NC}"
    echo -e "${ORANGE}              INSTRUCTIONS                             ${NC}"
    echo -e "${ORANGE}-------------------------------------------------------${NC}"
    echo -e "1. Click the ${GREEN}Load Temporary Add-on...${NC} button."
    echo -e "2. In the file selection window, press ${ORANGE}Ctrl+L${NC} (or paste location)."
    echo -e "3. Paste this exact path:"
    echo ""
    echo -e "   ${GREEN}$FIREFOX_MANIFEST${NC}"
    echo ""
    echo -e "4. Click ${GREEN}Open${NC}."
    echo -e "${ORANGE}-------------------------------------------------------${NC}"
else
    echo "Skipping Firefox helper."
    echo "To install later, load '$SOURCE_DIR/extras/firefox/manifest.json' in about:debugging."
fi

# --- 7. Final Instructions ---
echo ""
echo -e "${ORANGE}==========================================${NC}"
echo -e "${GREEN}INSTALLATION COMPLETE${NC}"
echo -e "${ORANGE}==========================================${NC}"
echo ""
echo "To apply the changes:"
echo ""
echo "1. Open ${ORANGE}COSMIC Settings${NC} -> ${ORANGE}Desktop${NC} -> ${ORANGE}Appearance${NC}."
echo "2. Under 'Icons', select ${GREEN}MaterialOS${NC} (Recommended) or ${GREEN}$THEME_NAME${NC}."
echo "3. Under 'Theme', click ${ORANGE}Import${NC} and navigate to:"
echo "   ${GREEN}$HOME/.local/share/cosmic/themes/${NC}"
echo "   Select either 'Anthropic_Claude_Inspired.ron' (Solid) or 'Anthropic_Claude_Frosted.ron' (Blurred)"
echo "4. Open ${ORANGE}COSMIC Terminal${NC} -> ${ORANGE}Settings${NC} -> ${ORANGE}Profiles${NC}."
echo "   Select ${GREEN}Anthropic Claude${NC}."
echo "5. Select the wallpaper in ${ORANGE}Desktop${NC} -> ${ORANGE}Wallpaper${NC}."
echo ""
echo "Enjoy your new desktop!"