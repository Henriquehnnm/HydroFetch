<h1 align="center">HydroFetch</h1>

<p align="center">
  <strong>The primary version is now the Fish script! 🎉</strong>
</p>
<p align="center">A modern, minimalist, and stylish system information tool.</p>

HydroFetch is a **fast and lightweight alternative to Neofetch**, focusing on simplicity, aesthetics, and essential system information.

## Features

- ✨ **Minimalist Design:** Shows only the most important system information in a clean layout.
- ⚡ **Fast and Lightweight:** Runs instantly with minimal system resource usage.
- 🎨 **Stylish Output:** Neon-inspired visuals and Nerd Font icons for a modern look.
- 🖥️ **Modern Alternative to Neofetch:** Simple, functional, and visually appealing.
- 🔌 **Extensible:** More Linux distributions and features coming soon!

## Installation

1. **Download** the appropriate `hydrofetch.fish` script from this repository.
2. **Make it executable:**
   ```bash
   chmod +x hydrofetch.fish
   ```
3. **Run the script:**
   ```fish
   ./hydrofetch.fish
   ```
4. *(Optional)* **Create an alias** in your fish shell configuration for easy access:
   ```fish
   echo "alias hydrofetch='~/path/to/hydrofetch.fish'" >> ~/.config/fish/config.fish
   source ~/.config/fish/config.fish
   ```

### Requirements

- **Nerd Font:** For the best visual experience, make sure you have a [Nerd Font](https://www.nerdfonts.com/) installed and set as your terminal font.
- **Figlet:** HydroFetch uses `figlet` for ASCII art. The script will attempt to install it automatically if not found.

## Usage

### Fish Version (Recommended)
The Fish version is the primary and most feature-rich version of HydroFetch.
```fish
./hydrofetch.fish [option]
```

### Bash Version (Legacy)
A legacy version for `bash` users is also available, though it may not receive all new features.
```bash
./hydrofetch.sh [option]
```

### Available Options

- `-h`, `--help`  
  Show the help message with usage instructions.
- `--all`  
  Display detailed and complete system information.
- `--tux`  (Only in the Bash version, farewell easter egg for this version)
  Show a fun Tux (Linux mascot) easter egg.
- **Custom Font:**  
  For a personalized ASCII logo, place a `Custom.flf` font file in `~/.hydrofetch`.

## Preview

<p align="center">
  <img width="598" height="511" alt="image" src="https://github.com/user-attachments/assets/930ed3d4-d452-4b13-9eaa-907162179bb0" />
</p>

## Contribution

Contributions are welcome!  
Feel free to open issues or submit pull requests to add features, fix bugs, or improve documentation.
