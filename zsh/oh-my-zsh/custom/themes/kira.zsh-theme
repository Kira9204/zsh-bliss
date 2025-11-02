# By: Erik Welander (erik.welander@hotmail.com)
setopt PROMPT_SUBST

# args= ; for code in {000..255} ; { args+=("$code %K{$code}%F{$code}XX%f%k") } ; print -cP -- $args
# %F{color} sets foreground color
# %K{color} sets background color
# %f resets foreground color to default
# %k resets background color to default
#
# If you are using Visual Studio Code:
# "terminal.integrated.minimumContrastRatio": 1

local COLOR_FOREGROUND_PRIMARY="015"
local COLOR_BACKGROUND_HOST="166"
local COLOR_BACKGROUND_USER_ROOT="052"
local COLOR_BACKGROUND_PATH="021"
local COLOR_BACKGROUND_TIME="240"
local COLOR_BACKGROUND_EXIT_CODE_SUCCESS="30"
local COLOR_BACKGROUND_EXIT_CODE_FAILURE="198"
local COLOR_BACKGROUND_BRANCH_SYNCED="028"
local COLOR_BACKGROUND_BRANCH_NOT_SYNCED="136"
local COLOR_BACKGROUND_JAVA="130"
local COLOR_BACKGROUND_NODE="136"

# Save the last command execution time
local last_cmd_time=""
local last_exit_code=0
# Executed just after a command has been read and is about to be executed.
preexec() {
  cmd_start=$(($(print -P %D{%s%6.}) / 1000))
}

# Executed before each prompt
precmd() {
  last_exit_code=$?

  if [ $cmd_start ]; then
    local now=$(($(print -P %D{%s%6.}) / 1000))
    local d_ms=$(($now - $cmd_start))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))

    if ((h > 0)); then
      cmd_time=${h}h${m}m
    elif ((m > 0)); then
      cmd_time=${m}m${s}s
    elif ((s > 9)); then
      cmd_time=${s}.$(printf %03d $ms | cut -c1-2)s # 12.34s
    elif ((s > 0)); then
      cmd_time=${s}.$(printf %03d $ms)s # 1.234s
    else
      cmd_time=${ms}ms
    fi

    unset cmd_start
  else
    # Clear previous result when hitting Return with no command to execute
    unset cmd_time
  fi
  last_cmd_time="${cmd_time}"
}

segment_host() {
  if [[ $UID -eq 0 ]]; then
    echo "%K{$COLOR_BACKGROUND_USER_ROOT} %M ROOT %k"
  else
    echo "%K{$COLOR_BACKGROUND_HOST} %M %n %k"
  fi
}

segment_path() {
  echo "%K{$COLOR_BACKGROUND_PATH} %~ %k"
}

segment_git() {
  if ! command -v git > /dev/null 2>&1; then
    return
  fi

  local ref dirty status git_dir action state

  # check if in git repo
  git_dir=$(git rev-parse --git-dir 2> /dev/null) || return

  # get branch name or short commit hash
  ref=$(git symbolic-ref --quiet HEAD 2> /dev/null || git rev-parse --short HEAD 2> /dev/null)
  ref=${ref##refs/heads/}

  # check for dirty state (modified files or untracked files)
  if ! git diff --quiet --ignore-submodules HEAD 2> /dev/null || [[ -n $(git ls-files --others --exclude-standard 2> /dev/null) ]]; then
    dirty="*"
  fi

  # detect ongoing git operation
  if [[ -d "$git_dir/rebase-merge" ]]; then
    action="REBASE-MERGE"
  elif [[ -d "$git_dir/rebase-apply" ]]; then
    if [[ -f "$git_dir/rebase-apply/rebasing" ]]; then
      action="REBASE"
    elif [[ -f "$git_dir/rebase-apply/applying" ]]; then
      action="APPLY"
    else
      action="REBASE?"
    fi
  elif [[ -f "$git_dir/MERGE_HEAD" ]]; then
    action="MERGING"
  elif [[ -f "$git_dir/CHERRY_PICK_HEAD" ]]; then
    action="CHERRY-PICKING"
  elif [[ -f "$git_dir/REVERT_HEAD" ]]; then
    action="REVERTING"
  fi

  # combine info
  if [[ -n "$action" ]]; then
    state="|$action"
  else
    state=""
  fi

  local bg_color
  if [[ -n "$dirty" || -n "$action" ]]; then
    bg_color="$COLOR_BACKGROUND_BRANCH_NOT_SYNCED"
  else
    bg_color="$COLOR_BACKGROUND_BRANCH_SYNCED"
  fi
  echo "%K{$bg_color} ${ref}${state}${dirty} %k"
}

segment_java() {
  if ! command -v java > /dev/null 2>&1; then
    return
  fi

  # Check for Java project files or JAR files
  local matched_file=false
  # Use find to avoid glob expansion issues
  if [[ $(find . -maxdepth 1 -name "*.jar" -type f 2> /dev/null | wc -l) -gt 0 ]]; then
    matched_file=true
  fi

  if [[ -f pom.xml || -f build.gradle || -f build.gradle.kts || -f gradle.properties || -f settings.gradle || $has_jar_files == true ]]; then
    local version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo "%K{$COLOR_BACKGROUND_JAVA} JAVA $version %k"
  fi
}

segment_node() {
  if ! command -v node > /dev/null 2>&1; then
    return
  fi

  # Check for JavaScript/TypeScript project files
  local matched_file=false

  if [[ $(find . -maxdepth 1 -name "*.js" -type f 2> /dev/null | wc -l) -gt 0 ]]; then
    matched_file=true
  fi
  if [[ $(find . -maxdepth 1 -name "*.ts" -type f 2> /dev/null | wc -l) -gt 0 ]]; then
    matched_file=true
  fi
  if [[ $(find . -maxdepth 1 -name "package.json" -type f 2> /dev/null | wc -l) -gt 0 ]]; then
    matched_file=true
  fi

  if [[ -f package.json || $matched_file == true ]]; then
    local version=$(node -v 2>&1 | awk -F 'v' '{print $2}')
    echo "%K{$COLOR_BACKGROUND_NODE} NODE $version %k"
  fi

}

segment_programming_language() {
  segment_java
  segment_node
}

segment_time() {
  echo "%K{$COLOR_BACKGROUND_TIME} $(date +'%Y-%m-%d %H:%M:%S') %k"
}

segment_exit() {
  if [[ $last_exit_code -eq 0 ]]; then
    if [[ -n "$last_cmd_time" ]]; then
      echo "%K{$COLOR_BACKGROUND_EXIT_CODE_SUCCESS} OK (${last_cmd_time}) %k"
    else
      echo "%K{$COLOR_BACKGROUND_EXIT_CODE_SUCCESS} OK %k"
    fi
  else
    if [[ -n "$last_cmd_time" ]]; then
      echo "%K{$COLOR_BACKGROUND_EXIT_CODE_FAILURE} FAIL (${last_cmd_time}) %k"
    else
      echo "%K{$COLOR_BACKGROUND_EXIT_CODE_FAILURE} FAIL %k"
    fi
  fi
}

segment_last_char() {
  if [[ $UID -eq 0 ]]; then
    echo "#"
  else
    echo "\$"
  fi
}
NL=$'\n'
export PROMPT='%f%k${NL}${NL}%F{$COLOR_FOREGROUND_PRIMARY}$(segment_host)$(segment_path)$(segment_git)$(segment_programming_language)$(segment_time)$(segment_exit) %f%k ${NL}%F{$COLOR_FOREGROUND_PRIMARY}$(segment_last_char)%f%k '
