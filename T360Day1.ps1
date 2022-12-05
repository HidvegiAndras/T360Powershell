# kommentelni sorvégén
<# 
Több soros kommentek
-------------------------
#>

Get-Command -Module ActiveDirectory
Get-ADUser -Filter *
Get-ADComputer

Get-ADDomain
Get-ADForest
Get-ADObject


$myusers = Get-ADUser -Filter *
$myuser = Get-ADUser -Identity Lara

$myusers.Name
$myusers.DistinguishedName


$PSVersionTable
$env:USERDNSDOMAIN
$env:COMPUTERNAME

New-ADUser -Name Teszt -Department IT

Get-ADUser -Identity Teszt | select *
$myusers | Get-Member

Set-ADUser -Identity Teszt -Surname Példány
Remove-ADUser -Identity Teszt

Get-ADUser -Identity Teszt | Get-Member
#Get-ADUser -Identity Teszt | Remove-ADUser
Get-ADUser -Identity Teszt | Set-ADUser -Department NemIT

$myuser = Get-ADUser -Identity Teszt 
$myuser | Set-ADUser -StreetAddress 'Sarok 2.'

Get-ADGroup -Identity IT
$ITmemebers = Get-ADGroupMember -Identity IT

(Get-ADGroupMember -Identity IT).SamAccountName

$ITmemebers | Get-Member
$ITmemebers.SamAccountName
Get-Command -Noun ADGroupMember
Remove-ADGroupMember IT Teszt

New-ADGroup -Name FileServerAdmins -GroupScope Global
Add-ADGroupMember FileServerAdmins -Members Teszt
Get-ADGroupMember FileServerAdmins

Get-ADGroup IT
New-ADGroup -Name HelpDesk -Path "OU=IT,DC=Adatum,DC=com" -GroupScope Global

Add-ADGroupMember HelpDesk -Members Lara, Teszt
Get-ADGroupMember HelpDesk

Get-ADComputer | Get-Member

(Get-ADComputer -Filter *).DNSHostName
New-ADComputer -Name Demogep -DNSHostName LON-DEMO
Set-ADComputer -Identity Demogep -Enabled $false
Set-ADComputer -Identity Demogep -Enabled $True

New-ADComputer -Name Demogep2 -DNSHostName LON-DEMO2 `
    -Path "OU=Marketing,DC=Adatum,DC=com"

Get-ADComputer -Filter ' Name -like "Demo*" ' -Properties *
# Get-ADUser -Identity Teszt -Properties MemberOf

Get-ADOrganizationalUnit
Get-Command -Noun ADOrganizationalUnit
New-ADOrganizationalUnit -Name ITDemo -Path "OU=IT,DC=Adatum,DC=com" -ProtectedFromAccidentalDeletion $false

$keresoroot = "OU=IT,DC=Adatum,DC=com"
$keresoroot2 = "DC=Adatum,DC=com"

Get-ADComputer -SearchBase $keresoroot2 -Filter *  -Properties *

New-ADObject -Name JohnSmithcontact -Type contact -DisplayName "John Smith (Contoso.com)”

Get-ADObject -Filter 'ObjectClass -eq "contact"'

Get-ADObject -Filter 'ObjectClass -eq "user"'

Set-ADObject -Identity "CN=Lara Raisic,OU=IT,DC=Adatum,DC=com" `
     -Description "Member of support team"

Rename-ADObject -Identity "CN=HelpDesk,OU=IT,DC=Adatum,DC=com" -NewName SupportTeam

Get-ADUser Lara -Properties Description
