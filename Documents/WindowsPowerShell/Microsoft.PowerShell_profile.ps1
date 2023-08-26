function dfm { git --git-dir=$env:USERPROFILE\.dfm --work-tree=$env:USERPROFILE $args }
function dfmui { gitui -d $env:USERPROFILE\.dfm -w $env:USERPROFILE $args }
function proxy {
  $Maskbits = 24
  $Gateway = "192.168.5.7"
  $DNS = "192.168.5.7"
  $IPType = "IPv4"

  $adapter = Get-NetAdapter | Where-Object { $_.Status -eq "up" }
  $IP = ($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress

  if (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
    $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
  }
  if (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
    $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
  }


  $adapter | New-NetIPAddress -AddressFamily $IPType -IPAddress $IP -PrefixLength $MaskBits -DefaultGateway $Gateway
  # Configure the DNS client server IP addresses
  $adapter | Set-DnsClientServerAddress -ServerAddresses $DNS

  Write-Host "Proxy On"
}
function noproxy {
  $IPType = "IPv4"
  $adapter = Get-NetAdapter | Where-Object { $_.Status -eq "up" }
  $interface = $adapter | Get-NetIPInterface -AddressFamily $IPType

  if ($interface.Dhcp -eq "Disabled") {
    # Remove existing gateway
    if (($interface | Get-NetIPConfiguration).Ipv4DefaultGateway) {
      $interface | Remove-NetRoute -Confirm:$false
    }
    # Enable DHCP
    $interface | Set-NetIPInterface -Dhcp Enabled
    # Configure the DNS Servers automatically
    $interface | Set-DnsClientServerAddress -ResetServerAddresses
  }
}

# Remember install newer PSReadLine by: Install-Module -Force PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Chord "Ctrl+e" -Function ForwardWord

$fnmExists = Get-Command -Name fnm -ErrorAction SilentlyContinue
if ($fnmExists) { fnm env --use-on-cd | Out-String | Invoke-Expression }
$zoxideExists = Get-Command -Name zoxide -ErrorAction SilentlyContinue
if ($zoxideExists) { Invoke-Expression (& { (zoxide init powershell | Out-String) }) }
