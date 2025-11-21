<p align="center">
  <img src="Logo.png" alt="HydroFetch Logo" width="200"/>
</p>

<h1 align="center">HydroFetch</h1>

<p align="center">
  A fast, beautiful, and lightweight system information tool written exclusively for the Fish shell.
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Made%20with-Fish-1f95e6?style=for-the-badge&logo=fishshell&logoColor=white&color=96dd4b&labelColor=151b23" />
    <img src="https://img.shields.io/github/v/release/Henriquehnnm/HydroFetch?style=for-the-badge&color=96dd4b&labelColor=151b23&logoColor=ffffff" />
</p>

> **⚠️ Important Notice: Exclusive Focus on Fish Shell**
> 
> The Bash version of HydroFetch has been discontinued. The project is now focusing exclusively on the **Fish shell version** (`hydrofetch.fish`) to provide a more polished, feature-rich, and stable experience.

## Preview

<p align="center">
  <img alt="HydroFetch Preview" src="https://github.com/user-attachments/assets/930ed3d4-d452-4b13-9eaa-907162179bb0" />
</p>

## Features

- **Purely Fish Script:** Written entirely in Fish for maximum speed and efficiency within the Fish shell.
- **Essential Info:** Displays key system information like OS, Kernel, Desktop Environment, RAM, and more.
- **Smart Dependencies:** The installation script automatically checks for and installs required dependencies (`figlet`, `jq`, `wget`) using your system's package manager (supports `apt`, `dnf`, `pacman`, `zypper`, and `apk`).
- **Multi-language Support:** HydroFetch automatically detects your system language and, if a translation is available, displays information in your native language.
- **Highly Customizable:** Change icons, use custom `figlet` fonts, and add custom ASCII art for your OS.
- **Multiple Modes:** Includes a default view, a compact minimal mode (`--min`), and a detailed information mode (`--all`).

## Requirements

- **Fish Shell**
- **Nerd Font:** Required to display icons correctly. You can download one from [nerdfonts.com](https://www.nerdfonts.com/).
- `figlet` (The installation script will attempt to install it for you)
- `jq` (The installation script will attempt to install it for you)
- `wget` (The installation script will attempt to install it for you)

## Installation

### Easy Install (Recommended)

Run the following command in your terminal to automatically download and set up HydroFetch:

```fish
curl -sSL https://raw.githubusercontent.com/Henriquehnnm/HydroFetch/main/install.fish | fish
```

The script will install the tool to `~/.hydrofetch.fish` and create a convenient `hf` command in `~/.local/bin/`. After installation, restart your terminal and run `hf`.

### Manual Installation

1.  **Clone the repository:**
    ```fish
    git clone https://github.com/Henriquehnnm/HydroFetch.git
    cd HydroFetch
    ```

2.  **Run the installation script:**
    ```fish
    fish ./install.fish
    ```

## Usage

Once installed, you can run the script with the `hf` alias:

```fish
# Default view
hf

# Show all system information
hf --all

# Show information in a minimal, one-line format
hf --min

# Display the script version
hf --version

# Display the help message
hf --help
```

## Customization

You can customize HydroFetch by creating files in the `~/.config/hydrofetch/` directory.

### Custom Font

To use a custom `figlet` font for the OS ASCII art, place a font file named `Custom.flf` inside the `~/.config/hydrofetch/` directory.

### Custom Icons

You can override the default icons shown in the main info box by creating a `Config.json` file at `~/.config/hydrofetch/Config.json`.

Example `Config.json`:
```json
{
  "ICON_USER": " ",
  "ICON_HOST": "󰒋 ",
  "ICON_OS": " ",
  "ICON_KERNEL": "󰌽 ",
  "ICON_DE": " ",
  "ICON_RAM": " ",
  "ICON_COLORS": "󰌁 "
}
```
You only need to include the icons you want to change.

## Plugins

HydroFetch can be extended with community-made plugins for custom logos and more. To find and install plugins, visit the official plugins repository:

**[hydrofetch-plugins](https://github.com/Henriquehnnm/hydrofetch-plugins)**

## Contributing

Contributions are welcome! If you have ideas for new features, bug fixes, or improvements, feel free to open an issue or submit a pull request.

## License

This project is distributed under the terms of the LICENSE file.