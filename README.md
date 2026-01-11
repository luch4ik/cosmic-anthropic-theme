# Cosmic Theme - Crail Paper

A high-quality theme for the COSMIC Desktop Environment, originally inspired by the design language of Anthropic and Claude.

## Design Philosophy

This theme translates the warm, intelligent, and "paper-like" aesthetic into a system-wide desktop theme.

*   **Warm Charcoal Backgrounds:** Moving away from sterile cold grays to earthy, warm dark tones (`#141413`).
*   **Pampas White Text:** A soft, readable off-white (`#faf9f5`) that reduces eye strain.
*   **Crail Orange Accent:** The signature terracotta orange (`#d97757`) provides a distinct and sophisticated focus color.
*   **Nature-Inspired Functional Colors:** Muted greens, blues, and golds.

## Installation

### 1. COSMIC Tweaks / Settings (Recommended)
This theme file has been validated against the official COSMIC configuration structure.

1.  Open **COSMIC Settings** (or the COSMIC Tweaks app).
2.  Navigate to **Appearance** -> **Theme**.
3.  Click **Import**.
4.  Select one of the following:
    *   **`Crail_Paper_Solid.ron`**: The authentic, opaque "Paper" look (Recommended).
    *   **`Crail_Paper_Frosted.ron`**: A modern variant with translucent (85%), blurred backgrounds.
    *   **`Crail_Paper_Glass.ron`**: A high-transparency (60%) variant for maximum blur.

### 2. Manual Color Palette
If you prefer to only apply the colors without changing window geometry:

1.  Open **COSMIC Settings**.
2.  Navigate to **Desktop** -> **Appearance** -> **Accent Color**.
3.  Select **Custom/Import**.
4.  Select `Crail_Paper_Accent.ron`.

### 3. COSMIC Terminal
1.  Open **COSMIC Terminal**.
2.  Go to **Settings** -> **Profiles**.
3.  Select **Crail Paper**.
    *   *Note:* If it doesn't appear, you can manually import `Crail_Paper_Terminal.ron` from this folder.

### 4. Wallpaper
The installer places a high-quality PNG wallpaper in `~/.local/share/backgrounds/cosmic`.
1.  Go to **Desktop** -> **Wallpaper**.
2.  Select the **Anthropic Claude** background.

### 5. Extras
*   **GTK 4.0 Override:** Installed automatically to fix legacy GNOME apps.
*   **Firefox Theme:** Located in `extras/firefox`. Load it via `about:debugging` -> `This Firefox` -> `Load Temporary Ad-on`.

## Recommended Companion Icons
For a more comprehensive "Material" look that perfectly complements the geometry of this theme, we highly recommend the **MaterialOS Linux Icon Pack**:
*   **GitHub:** [materialos/Linux-Icon-Pack](https://github.com/materialos/Linux-Icon-Pack)

## Compatibility
This theme is designed for:
*   COSMIC Desktop Environment (Alpha/Beta releases)
*   Pop!_OS 24.04+ (with COSMIC)
*   Other distributions running COSMIC

## Disclaimer
It is not affiliated with, endorsed by, or associated with Anthropic PBC. "Claude" and "Anthropic" are trademarks of Anthropic PBC.

## License
MIT License