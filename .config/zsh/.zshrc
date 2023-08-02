# zmodload zsh/zprof # enable this line, use zprof to see zsh function load time
source ~/.config/zsh/zsh-snap/znap.zsh
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

znap eval starship 'starship init zsh'
znap prompt

znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions

# fnm & zoxide
znap eval fnm 'fnm env --use-on-cd'
znap eval zoxide 'zoxide init zsh --cmd z'
znap eval zoxide 'atuin init zsh'

# ignore duplicate history
setopt HIST_IGNORE_DUPS

# alias
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -lG'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias zshrc='vim ${ZDOTDIR:-$HOME}/.zshrc' # Quick access to the .zshrc file
alias t='tail -f'
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias ff='find . -type f -name'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias dfm="git --git-dir $HOME/.dfm --work-tree=$HOME"
alias dfmui="gitui -d $HOME/.dfm -w $HOME"

proxy() {
    subnet='255.255.255.0'
    router='192.168.2.11'
    dns='223.5.5.5'
    if [ "$1" != "eth" ]; then
        cip=$(ipconfig getifaddr en0)
        networksetup -setmanual Wi-Fi $cip $subnet $router
        networksetup -setdnsservers Wi-Fi $dns
        echo 'Wi-Fi Info: '
        networksetup -getinfo Wi-Fi
    else
        cip=$(ipconfig getifaddr en0)
        networksetup -setmanual Ethernet $cip $subnet $router
        networksetup -setdnsservers Ethernet $dns
        echo 'Ethernet Info: '
        networksetup -getinfo Ethernet
    fi
    sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
}

noproxy() {
    networksetup -setdhcp Wi-Fi
    networksetup -setdnsservers Wi-Fi empty
    #    networksetup -setdhcp Ethernet
    #    networksetup -setdnsservers Ethernet empty
    sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
    echo "Proxy Off"
}

list-jdk() {
    /usr/libexec/java_home -V
}

set-jdk() {
    if [ $# != 1 ]; then
        echo "usage example: set-jdk 1.8"
        return 1
    fi
    unset JAVA_HOME
    export JAVA_HOME=`/usr/libexec/java_home -v $1`
    export PATH=$JAVA_HOME/bin:$PATH
}
