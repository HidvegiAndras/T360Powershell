# Pipeline demo
# alapok
Get-command -noun Service

Get-Service | Set-Service
Get-Service | Restart-Service

Get-Service winrm* | Get-Member
(Get-Service).Status

# Formázások

Get-Service | Format-List
Get-Service | Format-Table -AutoSize
Get-Service | Format-Wide

Get-Service | Select * | Format-List -Property Name,Status, StartType


Get-Process | gm
Get-Process | Format-List
$futoapp = Get-Process | Select ProcessName, StartInfo, StartTime
$futoapp | Select ProcessName, StartTime -ExpandProperty StartInfo 


$szervizlista = Get-Service | Select Name,Status, StartType 

$szervizlista | Get-Member

# Rendezés

$szervizlista | Sort-Object -Property Name -Descending 

$futoapp | Sort-Object -Property Id, ProcessName


# Csoportosítás

$szervizlista | Sort-Object -Property Status, Name | Format-Table -GroupBy Status

$futoapp | Format-Table -GroupBy ProcessName


# Mértékek

$futoapp | Measure-Object -Property CPU, WS -Sum -Average -Maximum -Minimum

# Oszlopok (Select)

$futoapp | Select-Object -Property ProcessName, CPU, WS -Last 20
$futoapp | Select-Object -Property ProcessName -Unique -Last 20
$futoapp | Sort-Object CPU -Descending | Select-Object -First 10 -Skip 3

Get-ADUser -Filter * -Property Department | Sort-Object -Property Department | Select-Object -Unique

# Metodusok használata

(Get-Date).AddDays(3)
$most = Get-Date
$most.AddYears(6).Year
$most.AddDays(180).Date
$most.DayOfYear

# LAB 3.A

Get-Date | Select-Object -Property DayOfYear | fl

# Select-object számított mezõkkel

$hashtabla = @{name='name értéke';
               datum=Get-Date}

$hashtabla.ertek
$hashtabla.datum

Get-Process | Select-Object Name, ID, VM


#$PSItem alias $_
# lista aktuális eleme a feldolgozás során


@{n='Virtual Memory';e={$PSItem.VM}}
@{n='Page Memory';e={$PSItem.PM}}
@{n='Datum';e={Get-Date}}


Get-Process | Select-Object Name, ID, @{n='Virtual Memory';e={$PSItem.VM}}, @{n='Datum';e={Get-Date}}
Get-Process | Select-Object Name, ID, @{n='Virtual Memory';e={$PSItem.VM/1GB}}, @{n='Page Memory';e={$PSItem.PM/1MB}}
Get-Process | Select-Object Name, ID, @{n='Virtual Memory(MB)';e={'{0:N2}' -f $PSItem.VM/1MB}}, @{n='Page Memory';e={'{0:N2}' -f $PSItem.PM/1MB}}

$TimeSpan = New-TimeSpan -Hours 1 -Minutes 25

Get-Aduser -Filter * -Properties WhenCreated | Sort-Object WhenCreated -Descending | `
 Select DistinguishedName, WhenCreated  -First 2 | Format-Table

Get-Aduser -Filter * -Properties WhenCreated | Sort-Object WhenCreated -Descending | `
 Select-Object @{n='Account age (days)';e={(New-TimeSpan -Start $PSItem.WhenCreated).Days}} -First 2

Get-Aduser -Filter * -Properties WhenCreated | Sort-Object WhenCreated -Descending | `
 Select-Object Name, SamAccountName, @{n='Account age (days)';e={(New-TimeSpan -Start $PSItem.WhenCreated).Days}} -First 2

# Fájl kezelés

Get-Location
Set-Location C:\Windows

$workpath = 'C:\windows'
$workdir = 'System32'

$subdir = Join-Path -Path $workpath -ChildPath $workdir

Get-ChildItem $subdir

$fajllista = gci 'C:\Windows\System32\drivers\UMDF' -Recurse
$fajllista | Select-Object FullName, LastWriteTime, CreationTime

# Operátorok

= < > == 

-eq = 
-neq != 
-gt >
-ge >=

# Filter 

Get-Service | Where Status -eq Running
Get-Service | Where-Object {$PSItem.Status -eq 'Running'}
Get-Service | Where-Object {($PSItem.Name -like 'W*') -and ($PSItem.Status -eq 'Running')}

$fajllista | Where-Object {$PSItem.LastWriteTime -ne $PSItem.CreationTime} | Select-Object FullName, LastWriteTime, CreationTime

$limit = (Get-Date).AddDays(-15)
Get-ChildItem -Recurse | Where-Object {$PSItem.LastWriteTime -lt $limit}
Get-ChildItem -Path C:\ -Recurse | Where-Object {$PSItem.LastWriteTime -lt $limit}

$fajllista | Where-Object {$PSItem.Length -gt 100000} | Select-Object FullName, @{Name="KBytes";Expression={ "{0:N0}" -f ($PSItem.Length / 1KB)}}

$limit = (Get-Date).AddDays(-15)
Get-ChildItem -Recurse | Where-Object {$PSItem.LastWriteTime -lt $limit}
Get-ChildItem -Path C:\ -Recurse | Where-Object {$PSItem.LastWriteTime -lt $limit}

$fajllista | Where-Object {$PSItem.Length -gt 100000} | Select-Object FullName, @{Name="KBytes";Expression={ "{0:N0}" -f ($PSItem.Length / 1KB)}} | Get-Member
$fajllista | Where-Object {$PSItem.Length -gt 100000} | Copy-Item -Destination './Backup'

# Pipline byProperty Name

Get-ADComputer -Filter * | Select Name
Get-Process -ComputerName Lon-svr1
Get-ADComputer -Filter * | Select @{n='ComputerName';e={$PSItem.Name}} | Get-Process | Select-Object ProcessName, CPU | Out-File C:\Backup\query1.txt
Get-Help Stop-Process -full

Get-Process | Where-Object {$_.ProcessName -eq 'Notepad'} 
Get-Process -Name notepad | Stop-Process

Get-Process -ComputerName 172.16.0.11
(Get-ADComputer -Filter * | Select-Object -ExpandProperty Name)
Get-Process -ComputerName (Get-ADComputer -Filter * | Select-Object -Property Name)
Get-Process -ComputerName (Get-ADComputer -Filter * | Select-Object -ExpandProperty Name)
Get-Aduser Lara  -Properties MemberOf | Select-Object -ExpandProperty MemberOf | Get-ADGroup

Get-ADGroup "SupportTeam"
Get-ADGroup -filter * | Where-Object {$_.name -eq "SupportTeam"}

(Get-ADUser -Filter { City -eq "London" })
New-ADGroup "London Users" -GroupScope Universal
Get-ADGroup "London Users"

Get-ADGroup "London Users" | Get-ADGroupMember
Get-ADGroup "London Users" | ADD-ADGroupMember -Members (Get-ADUser -Filter { City -eq "London" })


# Foreach-Object

$users = Get-ADUser -filter *
$users.name
$users.samaccountname

Write-Host "vvalami"
$users | ForEach-Object {($PSItem.name).ToUpper()}
$users | ForEach-Object { Write-Host "A felhasználó neve: " $PSItem.Name}
1..10 | ForEach-Object {$PsItem; $PSItem *2; $PSItem * 3}


# Eredmények kiírása fileokba

$fajl = 'C:\Backup\query2.txt'
$fajl2 = 'C:\Backup\query2.html'
$users | Sort-Object Name | Select Name, DistinguishedName, Enabled | Out-File $fajl

$users | Sort-Object Name | Select Name, DistinguishedName, Enabled | ConvertTo-Csv | Out-File $fajl
$users | Sort-Object Name | Select Name, DistinguishedName, Enabled | ConvertTo-XML | Out-File $fajl
$users | Sort-Object Name | Select Name, DistinguishedName, Enabled | ConvertTo-Json | Out-File $fajl
$users | Sort-Object Name | Select Name, DistinguishedName, Enabled | ConvertTo-HTML | Out-File $fajl2
$users | Sort-Object Name | Select Name, DistinguishedName, Enabled |  Out-File $fajl2 -Encoding utf8
$users | Sort-Object Name | Select Name, DistinguishedName, Enabled | Export-Clixml $fajl

# AD Userek több OU-ból

Get-ADUser -Searchbase 'OU=IT,DC=Adatum,DC=com' -Filter * | Select Name, DistinguishedName, Enabled | Out-File $fajl
Get-ADUser -Searchbase 'OU=Marketing,DC=Adatum,DC=com' -Filter * | Select Name, DistinguishedName, Enabled | Out-File $fajl -Append

$ous = 'OU=IT,DC=Adatum,DC=com','OU=Marketing,DC=Adatum,DC=com'
$ous | ForEach-Object { Get-ADUser -Filter * -SearchBase $PSItem } | Select Name, DistinguishedName, Enabled
