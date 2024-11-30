
# dotfiles

This repository contains Adam Whitlock's personal home-manager configuration for managing dotfiles and system configurations. 

## Package Management

This configuration uses Flox for package management rather than home-manager's package management capabilities. While home-manager handles dotfiles and program configurations, all package installation and updates are managed through Flox commands (`flox install`, `flox update`, etc.). This separation provides more direct control over package management and allows for easier package state management across different systems. Home-manager's package management is intentionally disabled in this setup - if you need to install a new package, use `flox install package-name` instead of adding it to home-manager's configuration. 

I have added additional documentation for how to use Nix for installing home-manager. With that stated, nothing prevents you from using these configurations and Nix packages anyway you want.

## Prerequisites

You either need to have a working Nix (Nix Packages) setup OR something that can manage the dependencies for Nix. I've provided a couple different options for management. Right now, I'm playing with Flox so the Flox version will work.


### Option 1: Install Nix (Standard Setup)


1. First, ensure you have Nix installed. If not, install it:
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

2. Add the home-manager channel:
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

3. Install home-manager:
```bash
nix-shell '' -A install
```

4. Restart your shell or source your profile:
```bash
. $HOME/.nix-profile/etc/profile.d/nix.sh
```

5. Verify the installation:
```bash
home-manager --version
```


### Option 2: Install Flox (If You Use/Love Flox)

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

4. Pulling Configuration via Floxhub (optional)

To use the Flox configuration from FloxHub, you can pull it directly using the following command:

```bash
flox pull alloydwhitlock/default
```

5. SInstall Home Manager

With Flox installed, install home-manager using your default environment:
```bash
flox install home-manager
```

## Configuration Structure

Here's the basic configuration structure, showing how it's setup. This may differ over time from the actual structure:

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


To make this easy, I put this in my `on-activate` section in the default Flox environment. This is present in the FloxHub verison of my default configuration. 


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

1. Clone this repository
```bash
git clone <repository-url> ~/.config/dotfiles
```

2. Create a symlink for home-manager

```bash
ln -s "$HOME/.config/dotfiles/.config/home-manager" "$HOME/.config/home-manager"
```

3. Initial home-manager build & activation:
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
