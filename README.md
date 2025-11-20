<p align="center">
  <img src="Logo.png" alt="HydroFetch Logo" width="200"/>
</p>

<h1 align="center">HydroFetch</h1>

<p align="center">
  A fast, beautiful, and lightweight system information tool written in Fish shell.
</p>

<p align="center">
  <a href="https://github.com/Henriquehnnm/HydroFetch/releases">
    <img src="https://img.shields.io/github/v/release/Henriquehnnm/HydroFetch?style=for-the-badge" alt="GitHub release (latest by date)">
  </a>
</p>

> **❗️ Important Notice: Focus on Fish Shell ❗️**
> 
> Starting with version **2.5.0**, the Bash version of HydroFetch (`hydrofetch.sh`) will be archived and will no longer receive updates. The project is now focusing exclusively on the **Fish shell version** (`hydrofetch.fish`) to provide a more polished, feature-rich, and stable experience for users.

## Preview

<p align="center">
  <img alt="HydroFetch Preview" src="https://github.com/user-attachments/assets/930ed3d4-d452-4b13-9eaa-907162179bb0" />
</p>

## Features

- **Purely Fish Script:** Written entirely in Fish for maximum speed and efficiency within the Fish shell.
- **Essential Info:** Displays key system information: OS, Kernel, Desktop Environment, RAM, and more.
- **Smart Dependencies:** Automatically checks for and installs required dependencies (`figlet`, `jq`) using the system's package manager.
- **Customizable:** Supports custom `figlet` fonts.
- **Multiple Modes:** Includes a default view, a compact minimal mode (`--min`), and a detailed information mode (`--all`).

## Requirements

- **Fish Shell**
- **Nerd Font:** Required to display icons correctly. You can download one from [nerdfonts.com](https://www.nerdfonts.com/).
- `figlet` (The script will attempt to install it for you)
- `jq` (The script will attempt to install it for you)

## Installation

1.  **Clone the repository:**
    ```fish
    git clone https://github.com/Henriquehnnm/HydroFetch.git
    cd HydroFetch
    ```

2.  **Make the script executable:**
    ```fish
    chmod +x Fetch-scripts/hydrofetch.fish
    ```

3.  **Run it directly or create an alias for convenience.**
    To create an alias, add the following to your `~/.config/fish/config.fish` file, replacing the path with the correct location of the script:
    ```fish
    alias hf "/path/to/HydroFetch/Fetch-scripts/hydrofetch.fish"
    ```
    Then, reload your shell or run `source ~/.config/fish/config.fish`.

## Usage

Once installed, you can run the script with the following options:

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

You can customize HydroFetch to use your own logos or fonts. The script checks for custom files in the `~/.hydrofetch` directory.

### Custom Font

To use a custom `figlet` font for the OS ASCII art, place a font file named `Custom.flf` inside the `~/.hydrofetch/` directory.

## Plugins

HydroFetch can be extended with community-made plugins for custom logos and more. To find and install plugins, visit the official plugins repository:

**[hydrofetch-plugins](https://github.com/Henriquehnnm/hydrofetch-plugins)**

## Contributing

Contributions are welcome! If you have ideas for new features, bug fixes, or improvements, feel free to open an issue or submit a pull request.

## License

This project is distributed under the terms of the LICENSE file.
