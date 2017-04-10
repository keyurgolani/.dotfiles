# Load bash_completion if available

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Load bash_aliases if available

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Load bash_aliases if available

if [ -f ~/.bash_functions ]; then
  source ~/.bash_functions
fi

# Load bash_exports if available

if [ -f ~/.bash_exports ]; then
  source ~/.bash_exports
fi

#   Change Prompt
#   ------------------------------------------------------------

# Load bash_prompt if available

if [ -f ~/.bash_prompt ]; then
  source ~/.bash_prompt

  for file in ~/.{bash_prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
  done;
  unset file;
fi

# Git branch in prompt.

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;


