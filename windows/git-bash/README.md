You can get a "Linux like" environment straight in Windows by using [git for windows](https://gitforwindows.org/).
This installs a pre-configured MSYS
Follow these steps in order to use this zsh environment inside of windows:

1. Install [git for windows](https://gitforwindows.org/).
2. Run the `pacman-git-bash.sh` inside of **git bash**.
3. `pacman -Syyu` to update your system.
4. `pacman -S zsh`.
5. Install [Oh-my-zsh](https://ohmyz.sh/).
6. `cp -r zsh ~/.zsh`.
7. `cp ../../zshrc ~/.zshrc` 
8. Follow the instructions when the shell starts on how to install `zsh-autosuggestions` and `zsh-syntax-highlighting`.
9. To set zsh as your default shell: `cp bashrc ~/.bashrc`

For additional packages, visit the [msys package repository](https://packages.msys2.org/base).
When installing packages, always use the `MINGW64` version of the package!

For Neovim support:
1. Install the Windows version from [here](https://github.com/neovim/neovim/blob/master/INSTALL.md).
2. Add the location of the exe to your `path` environment variable in windows.
3. Copy the nvim folder to `%localappdata%`.
