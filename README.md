
# dotfiles

This repository contains Adam Whitlock's personal home-manager configuration for managing dotfiles and system configurations. 

## Package Management

This configuration uses Flox for package management rather than home-manager's package management capabilities. While home-manager handles dotfiles and program configurations, all package installation and updates are managed through Flox commands (`flox install`, `flox update`, etc.). This separation provides more direct control over package management and allows for easier package state management across different systems. Home-manager's package management is intentionally disabled in this setup - if you need to install a new package, use `flox install package-name` instead of adding it to home-manager's configuration. This approach ensures consistent package management through Flox while letting home-manager focus on configuration management.

With that stated, nothing prevents you from using these configurations and Nix packages anyway you want.

## Prerequisites

### Install Flox

1. Visit [Flox Installation Guide](https://flox.dev/docs/install-flox/) and follow the installation instructions for your operating system.

2. After installation, add Flox to your `.bashrc`:
```bash
# Enable Flox
eval $(flox activate)
```

3. Restart your shell or source your `.bashrc`:
```bash
source ~/.bashrc
```

### Install Home Manager

With Flox installed, install home-manager using your default environment:
```bash
flox install home-manager
```

## Configuration Structure

```
~/.config/home-manager/
├── home.nix                 # Main configuration entry point
└── profiles
    ├── default.nix          # Profile selection logic
    ├── default/             # Base profile (always loaded)
    │   ├── default.nix
    │   ├── packages.nix
    │   └── programs/
    │       ├── alacritty.nix
    │       ├── git.nix
    │       ├── tmux.nix
    │       └── vim.nix
    └── work/                # Work profile (adds to defaults unless specified)
        ├── default.nix
        ├── packages.nix
        └── programs/
            └── work-specific.nix
```

## Profile Management

The configuration supports multiple profiles:
- **default**: Base configuration used everywhere
- **work**: Additional work-specific configurations, like Git config

### Switching Profiles

If you want to switch profiles, use the NIX_PROFILE_NAME to switch between versions.

For normal use:
`export NIX_PROFILE_NAME=default` 


For work profile:
`export NIX_PROFILE_NAME=work` 


To make this easy, I put this in my `on-activate` section in the default Flox environment, which assumes my work home directory is named a certain way:


#### Flox Snippet
```
export NIX_PROFILE_NAME="default"

# Check if home directory named/contains "adamwhitlock" or has .work file
if [[ "$HOME" == *"adamwhitlock"* ]] || [ -f "$HOME/.work" ]; then
    export NIX_PROFILE_NAME="work"
fi
```


## Usage

### First Time Setup

1. Clone this repository:switch
```bash
git clone <repository-url> ~/.config/home-manager
```

2. Initial switch:
```bash
home-manager switch
```

### Making Changes

1. Edit configuration files as needed
2. Apply changes:
```bash
home-manager switch
```

### Adding New Programs

1. Create a new configuration file in the appropriate profile directory
2. Import it in the profile's `default.nix`
3. Apply changes with `home-manager switch`

## Troubleshooting

### Common Issues

1. **Files already exist**: Use backup flag
```bash
home-manager switch -b backup
```

2. **Check configuration**:
```bash
home-manager build
```

3. **Show trace for errors**:
```bash
home-manager switch --show-trace
```

### Profile Detection

To verify which profile is active:
```bash
echo $NIX_PROFILE_NAME
```

## Notes

- The default profile is always loaded
- Work profile adds to (doesn't replace) the default profile
- Configuration changes require running `home-manager switch`
- Keep backups of important configurations before major changes



## History
* 2024.11.29 - Massive rewrite, removed all original configuration files, pushed into using Home Manager (Nix) 
* 2021.01.18 - Added .bashrc options for modernizing (Pop!\_OS compatability), .vimrc cleanup. Removed unused Molokai theme, added Alacritty config
* 2018.04.22 - Removed Vundle plugin support from dotfiles, added show/hide status for .tmux.conf, notes for using GNU Stow (thanks to [Kyle Reid](https://github.com/kreid/dotfiles) for the inspiration)
* 2017.03.28 - Fixed .tmux.conf to support newer tmux directives for mouse & UDF
* 2017.03.27 - Added Vundle plugin support, .vimrc improvements for Python development
* 2016.11.04 - Added history options, .bash\_profile, .gitconfig
* 2016.09.08 - Modified Bash prompt to include relative directory path
* 2016.08.10 - Added Molokai theme for Vim
* 2016.07.17 - Creation and initial commit of basic dotfiles