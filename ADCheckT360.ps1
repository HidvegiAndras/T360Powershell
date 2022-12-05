
# Ellenörző lekérdezés
# 
# A $sorszamom, $nevem, és a 4 $keresoroot változóknak a helyes értékét állítsd be a saját domain beállításaid szerint.
# A $outfile változóban az útvonalat (C:\Peldashare\) javítani kell a számodra helyesre, a fájl neve maradjon.
# Legalább a gyakorlás előtt és után futtasd le
#

## !!!!!  
$sorszamom = "00"
$nevem = "Hidvégi András"
$keresoroot = "OU=Peldaceg,DC=testlab,DC=local"
$userkeresoroot = "OU=PeldaUsers,OU=Peldaceg,DC=testlab,DC=local"
$groupkeresoroot = "OU=PeldaGroups,OU=Peldaceg,DC=testlab,DC=local"
$computerkeresoroot = "OU=PeldaComputers,OU=Peldaceg,DC=testlab,DC=local"

$outfile = "C:\Peldashare\"+$sorszamom+"Users$mostvan.txt" #az útvonalat (C:\Peldashare\) javítani kell, a fájl neve maradjon

$mostvan = (Get-Date -Format FileDateTime).Substring(0,15)
$logstring = @("","----------------------------------------------", "", "Név: $nevem","Sorszám :$sorszamom", "Készült: $mostvan") 

#Létrejön a log file
$logstring | Out-File $outfile

$userproperties1 = "SamAccountName", "UserPrincipalName", "DistinguishedName", "CanonicalName", "ObjectGUID", "Memberof"
$userproperties2 = "SamAccountName", "Created", "Modified", "logonCount", "LastLogonDate", "LastBadPasswordAttempt", "PasswordExpired", "PasswordLastSet", "PasswordNeverExpires", "PasswordNotRequired", "ProtectedFromAccidentalDeletion"
$userproperties3 = "SamAccountName", "DisplayName", "Description", "StreetAddress", "State", "City", "PostalCode", "Country", "Title", "Department", "Manager"

$groupproperties1 = "SamAccountName", "DistinguishedName", "CanonicalName", "ObjectGUID", "ProtectedFromAccidentalDeletion" 
$groupproperties2 = "SamAccountName", "Created", "Modified", "Members"

$computerproperties1 = "CN", "OperatingSystem","DistinguishedName", "CanonicalName", "ObjectGUID", "ProtectedFromAccidentalDeletion" 
$computerproperties2 = "CN", "Created", "Modified", "logonCount", "LastLogonDate", "LastBadPasswordAttempt", "PasswordExpired", "PasswordLastSet", "PasswordNeverExpires", "PasswordNotRequired", "ProtectedFromAccidentalDeletion"

# Lekérdezések
$users = Get-ADUser -SearchBase $userkeresoroot -Filter * -Properties *
$groups = Get-ADGroup -SearchBase $groupkeresoroot -Filter * -Properties *
$computers = Get-ADComputer -SearchBase $computerkeresoroot -Filter * -Properties *

# Kiiratás
$logstring = @("","---------------------------------------------------- User adatok ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

$users | Sort-Object SamaccountName | Select-Object $userproperties1 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append
$users | Sort-Object SamaccountName | Select-Object $userproperties2 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append
$users | Sort-Object SamaccountName | Select-Object $userproperties3 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append

$logstring = @("---------------------------------------------------- Group adatok ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

$groups | Sort-Object SamaccountName | Select-Object $groupproperties1 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append
$groups | Sort-Object SamaccountName | Select-Object $groupproperties2 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append

$logstring = @("---------------------------------------------------- Computer adatok ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

$computers | Sort-Object SamaccountName | Select-Object $computerproperties1 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append
$computers | Sort-Object SamaccountName | Select-Object $computerproperties2 | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append

$logstring = @("---------------------------------------------------- Házirend objektumok ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

Get-GPO -all | Select-Object DisplayName, Id, CreationTime, ModificationTime, GpoStatus | Format-Table -AutoSize | Out-String -Width 4096 | Out-File $outfile -Append

$logstring = @("---------------------------------------------------- Csoportok tagjai ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

foreach ($group in $groups){ Get-ADGroupMember $group | Select-Object $group.name, name | Out-File $outfile -Append }

$logstring = @("---------------------------------------------------- Userek csoportjai ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append

foreach ($user in $users) { $user.memberof | ForEach-Object { Get-ADGroup -Filter * -SearchBase $_ -Properties * | Select-Object $user.SamAccountName, Name } | Out-File $outfile -Append }

$logstring = @("---------------------------------------------------- Vége ---------------------------------------------------------------","")
$logstring | Out-File $outfile -Append