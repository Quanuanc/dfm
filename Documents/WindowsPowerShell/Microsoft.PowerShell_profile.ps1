function dfm(){git --git-dir=$env:USERPROFILE\.dfm --work-tree=$env:USERPROFILE $args}

function dfmui(){gitui -d $env:USERPROFILE\.dfm -w $env:USERPROFILE $args}

# Remember install newer PSReadLine by: Install-Module -Force PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Chord "Ctrl+e" -Function ForwardWord

$fnmExists = Get-Command -Name fnm -ErrorAction SilentlyContinue
if($fnmExists){ fnm env --use-on-cd | Out-String | Invoke-Expression }

$zoxideExists = Get-Command -Name zoxide -ErrorAction SilentlyContinue
if($zoxideExists){ Invoke-Expression (& { (zoxide init powershell | Out-String) }) }
