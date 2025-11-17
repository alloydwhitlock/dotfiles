# dotfiles

Collection of various configuration files used by Adam Whitlock.

## Installation

1. Clone the dotfiles repository
   ```
   git clone https://github.com/alloydwhitlock/dotfiles.git ~/.config/dotfiles
   ```

2. Install [GNU Stow](https://www.gnu.org/software/stow/)
   
   On Mac OS X, using [Homebrew](https://brew.sh) to install GNU Stow is probably the easiest option
   ```
   brew install stow
   ```

3. Run `stow` commands to create symlinks for each of the folders containing dotfiles

### GNU Stow Example

```
$ cd ~/.config/dotfiles
$ stow -t ~ -vv tmux
LINK: .tmux.conf => .config/dotfiles/tmux/.tmux.conf
```

### Stowing Everything

```bash
cd ~/.config/dotfiles
stow -t ~ bash git tmux vim zsh alacritty ssh vscode
```

Or just stow everything at once:
```bash
stow -t ~ */
```

## Repository Structure

Each directory is a "stow package" containing related dotfiles:

```
~/.config/dotfiles/
├── alacritty/     # Terminal emulator config
├── bash/          # Bash shell (.bashrc, .bash_profile)
├── git/           # Git configuration
├── ssh/           # SSH keys and config
├── tmux/          # Tmux configuration
├── vim/           # Vim configuration
├── vscode/        # VSCodium/VS Code settings
└── zsh/           # Zsh shell configuration
```

## Usage

### Adding New Dotfiles

1. Create a directory for the program
2. Move your dotfile into it (preserving path from `$HOME`)
3. Stow it

Example:
```bash
mkdir -p ~/.config/dotfiles/newprogram
mv ~/.newprogramrc ~/.config/dotfiles/newprogram/.newprogramrc
cd ~/.config/dotfiles
stow -t ~ newprogram
```

### Removing Stowed Configurations

```bash
cd ~/.config/dotfiles
stow -t ~ -D vim  # Unstow vim
```

### Updating Configurations

Just edit the files directly—they're symlinked:
```bash
vim ~/.vimrc  # Edits ~/.config/dotfiles/vim/.vimrc
```

## Machine-Specific Settings

For settings that shouldn't be in version control:
- **Bash**: Create `~/.bashrc_local`
- **Zsh**: Create `~/.zshrc_local`

These files are automatically sourced if they exist.

## Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## History

* 2025.11.16 - Migrated back to GNU Stow from home-manager
* 2024.11.29 - Massive rewrite, removed all original configuration files, pushed into using Home Manager (Nix) 
* 2021.01.18 - Added .bashrc options for modernizing (Pop!\_OS compatability), .vimrc cleanup. Removed unused Molokai theme, added Alacritty config
* 2018.04.22 - Removed Vundle plugin support from dotfiles, added show/hide status for .tmux.conf, notes for using GNU Stow (thanks to [Kyle Reid](https://github.com/kreid/dotfiles) for the inspiration)
* 2017.03.28 - Fixed .tmux.conf to support newer tmux directives for mouse & UDF
* 2017.03.27 - Added Vundle plugin support, .vimrc improvements for Python development
* 2016.11.04 - Added history options, .bash\_profile, .gitconfig
* 2016.09.08 - Modified Bash prompt to include relative directory path
* 2016.08.10 - Added Molokai theme for Vim
* 2016.07.17 - Creation and initial commit of basic dotfiles

## License

GNU General Public License v3 (GPLv3)
