$ertek = 6
Switch ($ertek) {
    1 { Get-Date }
    2 { (Get-Date).AddDays(1) }
    3 { (Get-Date).AddYears(2) }
    default { Write-Host Default}
}

$ip = Get-NetIPAddress -AddressFamily IPv4 | Select IPAddress -first 1

Switch ($ip.IPAddress.ToString()) {
    "10.*" { Write-Host "IP1" }
    "172.16.0.10" { Write-Host "IP2" }    
}
