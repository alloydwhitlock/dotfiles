
# dotfiles
Collection of various configuration files used by Adam Whitlock. 

## Installation
 1. Clone the dotfiles repository
	 ```
	 git clone https://github.com/alloydwhitlock/dotfiles.git
	 ```
 3. Install [GNU Stow](https://www.gnu.org/software/stow/)
	 a. On Mac OS X, using [Homebrew](https://brew.sh) to install GNU Stow is probably the easiest option
	 ```
	 brew install stow
	 ``` 
 4. Run `stow` commands to create symlinks for each of the folders containing .dotfiles

### GNU Stow Example
```
$ cd ~/.dotfiles
$ stow -vv tmux
MacBook-Pro:.dotfiles whitlock$ stow -vv tmux
stow dir is /Users/whitlock/.dotfiles
stow dir path relative to target /Users/whitlock is .dotfiles
Planning stow of package tmux...
LINK: .tmux.conf => .dotfiles/tmux/.tmux.conf
Planning stow of package tmux... done
Processing tasks...
Processing tasks... done
```

## Contributing
1. Fork the repository
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## History
* 2018.04.22 - Removed Vundle plugin support from dotfiles, added show/hide status for .tmux.conf, notes for using GNU Stow (thanks to [Kyle Reid](https://github.com/kreid/dotfiles) for the inspiration)
* 2017.03.28 - Fixed .tmux.conf to support newer tmux directives for mouse & UDF
* 2017.03.27 - Added Vundle plugin support, .vimrc improvements for Python development
* 2016.11.04 - Added history options, .bash_profile, .gitconfig
* 2016.09.08 - Modified Bash prompt to include relative directory path
* 2016.08.10 - Added Molokai theme for Vim
* 2016.07.17 - Creation and initial commit of basic dotfiles


## License
GNU General Public License v3 (GPLv3)
