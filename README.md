# Cosmic Theme - Anthropic Claude (Inspired)

A high-quality theme for the COSMIC Desktop Environment, inspired by the design language of Anthropic and Claude.

## Design Philosophy

This theme translates the warm, intelligent, and "paper-like" aesthetic into a system-wide desktop theme.

*   **Warm Charcoal Backgrounds:** Moving away from sterile cold grays to earthy, warm dark tones (`#141413`).
*   **Pampas White Text:** A soft, readable off-white (`#faf9f5`) that reduces eye strain.
*   **Crail Orange Accent:** The signature terracotta orange (`#d97757`) provides a distinct and sophisticated focus color.
    *   *Note:* `text_tint` is set to Pampas White to ensure high contrast against the bright orange accent.
*   **Nature-Inspired Functional Colors:** Muted greens, blues, and golds derived from the official brand palette.

## Installation

### 1. COSMIC Tweaks / Settings (Recommended)
This theme file has been validated against the official COSMIC configuration structure.

1.  Open **COSMIC Settings** (or the COSMIC Tweaks app).
2.  Navigate to **Appearance** -> **Theme**.
3.  Click **Import**.
4.  Select one of the following:
    *   **`Anthropic_Claude_Inspired.ron`**: The authentic, opaque "Paper" look (Recommended).
    *   **`Anthropic_Claude_Frosted.ron`**: A modern variant with translucent (85%), blurred backgrounds.
    *   **`Anthropic_Claude_Glass.ron`**: A high-transparency (60%) variant for maximum blur.

### 2. Manual Color Palette
If you prefer to only apply the colors without changing window geometry:

1.  Open **COSMIC Settings**.
2.  Navigate to **Desktop** -> **Appearance** -> **Accent Color**.
3.  Select **Custom/Import**.
4.  Select `Anthropic_Claude_Accent.ron`.

### 3. COSMIC Terminal
1.  Open **COSMIC Terminal**.
2.  Go to **Settings** -> **Profiles**.
3.  Select **Anthropic Claude**.
    *   *Note:* If it doesn't appear, you can manually import `Anthropic_Claude_Terminal.ron` from this folder.

### 4. Icon Theme (Optional)
This package installs a custom icon set to match the theme (Crail Orange folders and app icons).

1.  The icons have been automatically installed to `~/.local/share/icons/Anthropic-Claude`.
2.  Open **COSMIC Settings**.
3.  Navigate to **Desktop** -> **Appearance** -> **Icons**.
4.  Select **Anthropic Claude**.

## Compatibility
This theme is designed for:
*   COSMIC Desktop Environment (Alpha/Beta releases)
*   Pop!_OS 24.04+ (with COSMIC)
*   Other distributions running COSMIC

## Disclaimer
It is not affiliated with, endorsed by, or associated with Anthropic PBC. "Claude" and "Anthropic" are trademarks of Anthropic PBC.

## License
MIT License