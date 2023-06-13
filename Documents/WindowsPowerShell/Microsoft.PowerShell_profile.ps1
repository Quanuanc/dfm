function dfm(){git --git-dir=$env:USERPROFILE\.dfm --work-tree=$env:USERPROFILE $args}

function dfmui(){gitui -d $env:USERPROFILE\.dfm -w $env:USERPROFILE $args}

fnm env --use-on-cd | Out-String | Invoke-Expression

# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Remember install newer PSReadLine by: Install-Module -Force PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Chord "Ctrl+e" -Function ForwardWord
