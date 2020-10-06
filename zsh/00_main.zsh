# ----------------------------------------------------------------------------
#                              BRIAN'S AWESOME ZSHRC
# ----------------------------------------------------------------------------

# TABLE OF CONTENTS:
# -------------------------------------
# 1.  Environment Variables
# 2.  Prompt
# 3.  Navigation and Searching
# 4.  File Operations
# 5.  Development
#   a.  Python
#   b.  Web
#   c.  Android
#   d.  Kubernetes
# 6.  Browser Tools

# ----------------------------------------------------------------------------
# 1.  ENVIRONMENT VARIABLES
# ----------------------------------------------------------------------------

#   Default Editor
#   -----------------------------------
    if [[ -n $SSH_CONNECTION ]]; then
      export EDITOR='vim'
    else
      export EDITOR='nvim'
    fi

#   Default Workspace Directory
#   -----------------------------------
    export WORKSPACE=$HOME/Workspace

#   Default Tools Directory
#   -----------------------------------
    export TOOLS=$WORKSPACE/tools

#   256 Color Support
#   -----------------------------------
    export TERM=xterm-256color


# ----------------------------------------------------------------------------
# 2.  PROMPT
# ----------------------------------------------------------------------------
#   Powerlevel10k
#   -----------------------------------
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# ----------------------------------------------------------------------------
# 3.  NAVIGATION AND SEARCHING
# ----------------------------------------------------------------------------

#   Go Back Aliases
#   -----------------------------------
    alias ..='cd ../'                
    alias ...='cd ../../'            
    alias .3='cd ../../../'          
    alias .4='cd ../../../../'       
    alias .5='cd ../../../../../'    

#   List Aliases
#   -----------------------------------
    alias ls="ls -G"
    alias l='ls -lh'
    alias la='ls -la'

#   Quickly Search for a File
#   -----------------------------------
    alias qfind="find . -name "

#   Quickly Search File Contents
#   -----------------------------------
    qgrep() {
        grep $1 -I -r ./
    }

#   Common Typos
#   -----------------------------------
    alias clera="clear"
    alias sl="ls"


# ----------------------------------------------------------------------------
# 4.  FILE OPERATIONS
# ----------------------------------------------------------------------------

#   Quickly extract most files
#   -----------------------------------
    extract () {
      if [ -f $1 ] ; then
        case $1 in
          *.tar.bz2)   tar xjf $1     ;;
          *.tar.gz)    tar xzf $1     ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar e $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xf $1      ;;
          *.tbz2)      tar xjf $1     ;;
          *.tgz)       tar xzf $1     ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)     echo "'$1' cannot be extracted via extract()" ;;
           esac
      else
        echo "'$1' is not a valid file"
      fi
    }


# ----------------------------------------------------------------------------
# 5.  DEVELOPMENT
# ----------------------------------------------------------------------------

#   Neovim aliases
#   -----------------------------------
    alias vim=nvim
    alias vi=nvim

#   Activate direnv
#   -----------------------------------
    eval "$(direnv hook zsh)"

#   Git Completion
#   -----------------------------------
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi

#   -----------------------------------
#   a. Python
#   -----------------------------------

#     Remove .pyc and .pyo files
#     ---------------------------------
      alias pyclean='find . -name "*.py[co]" -exec rm -rf {} \;'

#     Initialize a Python Package
#     ---------------------------------
      alias pyinit='touch __init__.py'
      
#     Setup Pyenv
#     ---------------------------------
      if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
      fi
      eval "$(pyenv virtualenv-init -)"
      # Prevent warnings from pyenv virtual env
      export PYENV_VIRTUALENV_DISABLE_PROMPT=1

#     Use ipb for debugging
#     ---------------------------------
      export PYTHONBREAKPOINT=ipdb.set_trace

#     Don't make a bunch of __pycache__ files
#     ---------------------------------
      export PYTHONDONTWRITEBYTECODE=1


#   -----------------------------------
#   b. Web
#   -----------------------------------

#     Start and Stop Proxy
#     ---------------------------------
      enable_http_proxy="http_proxy=http://127.0.0.1:8080"
      enable_https_proxy="https_proxy=http://127.0.0.1:8080"
      alias proxy="export $enable_http_proxy && export $enable_https_proxy"
      alias dproxy="unset http_proxy && unset https_proxy"
	
#     Start Burp
#     ---------------------------------
      alias burp="source $TOOLS/burp.jar"

#     HTTP Code Lookup
#     ---------------------------------
      function http() {
        curl http://httpcode.info/$1;
      }

#   -----------------------------------
#   c. Android
#   -----------------------------------

#     Restart ADB
#     ---------------------------------
      alias adb-restart="adb kill-server && adb devices"

#     Installed Packages on Device
#     ---------------------------------
      alias adb-list-packages="adb shell pm list packages"

#     Clear Logcat
#     ---------------------------------
      alias logcat-clear="adb logcat -c"

#     Show Logcat Errors
#     ---------------------------------
      alias logcat-errors="adb logcat -v threadtime *:E"

#     Show Logcat Warnings
#     ---------------------------------
      alias logcat-warns="adb logcat -v threadtime *:W"

#   -----------------------------------
#   d. Kubernetes
#   -----------------------------------

#     Kubeconfigs
#     ---------------------------------
      export KUBECONFIGSBASE=$WORKSPACE/kubeconfigs
      # Export configs
      for config in $KUBECONFIGSBASE/*.config; do
          [ -f "$config" ] || break
          if [ -z "$KUBECONFIG" ]
          then
              export KUBECONFIG=$config
          else
              export KUBECONFIG=$KUBECONFIG:$config
          fi
      done

#     Short Kubectl Aliases
#     ---------------------------------
      alias k=kubectl
      alias kx=kubectx
      alias kns=kubens

#     Autocompletion
#     ---------------------------------
      source <(kubectl completion zsh)
      complete -F __start_kubectl k
      complete -F _kube_contexts kx


# ----------------------------------------------------------------------------
# 6.  BROWSER TOOLS
# ----------------------------------------------------------------------------

#   Launch a Google search
#   ----------------------
    google() {
        search=""
        echo "Googling: $@"
        for term in $@; do
            search="$search%20$term"
        done
        # Uncomment the appropriate command for your system
        open "http://www.google.com/search?q=$search" # Mac OSX
        # xdg-open "http://www.google.com/search?q=$search" # Linux
        # start "http://www.google.com/search?q=$search" # Windows
    }
