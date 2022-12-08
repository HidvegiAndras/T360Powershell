Get-PSSession
$pss1 = New-PSSession -ComputerName Lon-svr1
$pss2 = New-PSSession -ComputerName Lon-svr1, Lon-cl1

Remove-PSSession $pss1
Enter-PSSession -Id 2
Get-Command -Noun PSSession

Invoke-Command -ComputerName Lon-svr1 -ScriptBlock { Get-NetIPAddress -AddressFamily IPv4 | Select IPAddress -First 1 }
$r = Invoke-Command -Session $pss2 -ScriptBlock { Get-NetIPAddress -AddressFamily IPv4 | Select IPAddress -First 1 }
$r.Ipaddress

Disconnect-PSSession $pss2
Connect-PSSession $pss2
Remove-PSSession $pss2

$param1 = "Szia"
$helyiparameter = "Szevasz"
Write-Host $param1 $env:COMPUTERNAME

#Helyi paraméter átadása másik gépen futó scriptnek
Invoke-Command -ComputerName Lon-svr1 -ScriptBlock { Param($tavoliparam)
    Write-Host $tavoliparam $env:COMPUTERNAME
} -ArgumentList ($helyiparameter)


Invoke-Command -ComputerName Lon-svr1 -ScriptBlock { $actualdir = Get-Location } # végrehajtás után a változó törlődik
Invoke-Command -ComputerName Lon-svr1 -ScriptBlock { Write-Host $actualdir } # Ez nem ad értéket vissza





