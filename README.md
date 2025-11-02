# zsh-bliss
Linux+Mac+Windows custom configurations and themes i use on my work and private machines.  
Lots of useful aliases for developers are included!  
Includes configuration for tools like VIM and Neovim too.

## Installation

#### Dependencies
- `zsh`
- `oh-my-zsh` (For history/tab completion)
- `lsd` (For `ls` icons and colors, falls back to `ls` if not installed)
- `bat` (For colored `cat` output, falls back to `cat` if not installed)
- `nvim` (Set as default editor)

Copy the files
- `cp -r ./zsh ~/.zsh`
- `cp -r ./nvim ~/.config`
- `cp ./etc/vimrc /etc/vimrc`
- `cp ./gitconfig ~/.gitconfig`

Include the configuration in your `~/.zshrc` file with
`source ~/.zsh/init.sh`

Screenshots:  

History completion
![history-completion.png](https://raw.githubusercontent.com/Kira9204/zsh-bliss/refs/heads/master/screenshots/history-completion.png)

Tab completion
![tab-completion.png](https://raw.githubusercontent.com/Kira9204/zsh-bliss/refs/heads/master/screenshots/tab-completion.png)

Git repo clean
![repo-clean.png](https://raw.githubusercontent.com/Kira9204/zsh-bliss/refs/heads/master/screenshots/repo-clean.png)

Git repo modified
![repo-modified.png](https://raw.githubusercontent.com/Kira9204/zsh-bliss/refs/heads/master/screenshots/repo-modified.png)  

Git repo Java project  
Uses `if [[ -f pom.xml || -f build.gradle || -f build.gradle.kts || -f gradle.properties || -f settings.gradle || $has_jar_files == true ]]; then` on the top level only
![repo-java.png](https://raw.githubusercontent.com/Kira9204/zsh-bliss/refs/heads/master/screenshots/repo-java.png)  

Git repo NodeJS project  
Uses `if [[ -f package.json || $has_js_ts_files == true ]]; then` on the top level only
![repo-nodejs.png](https://raw.githubusercontent.com/Kira9204/zsh-bliss/refs/heads/master/screenshots/repo-nodejs.png)  

Program exit code
![exit-code.png](https://raw.githubusercontent.com/Kira9204/zsh-bliss/refs/heads/master/screenshots/exit-code.png)  

Neovim
![nvim.png](https://raw.githubusercontent.com/Kira9204/zsh-bliss/refs/heads/master/screenshots/nvim.png)  
