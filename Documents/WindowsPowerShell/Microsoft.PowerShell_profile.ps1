function dfm(){git --git-dir=$env:USERPROFILE\.dfm --work-tree=$env:USERPROFILE $args}

function dfmui(){gitui -d $env:USERPROFILE\.dfm -w $env:USERPROFILE $args}

fnm env --use-on-cd | Out-String | Invoke-Expression

# For zoxide v0.8.0+
Invoke-Expression (& {
  $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
      (zoxide init --hook $hook powershell | Out-String)
})

# Remember install newer PSReadLine by: Install-Module -Force PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Chord "Ctrl+e" -Function ForwardWord
