$utvonaluserscsv = "\\lon-cl1\E$\Mod08\Democode\users.csv"
$utvonalcomputers = "\\lon-cl1\E$\Mod08\Democode\computers.txt"
$utvonalxml = "\\lon-cl1\E`$\Mod08\Democode\Users.xml"


$comptartalom = Get-Content $utvonalcomputers
$users = Import-Csv $utvonaluserscsv
$users.First
($users | Sort-Object First).First

Get-Content $utvonalxml
$usersxml = Import-Clixml $utvonalxml

$cred11 = Get-Credential ADATUM\Administrator
$cred11 | Export-Clixml C:\Backup\cred11.txt
$cred11.Password

New-CimSession -Credential $cred11 -ComputerName lon-cl1

$user22 = 'Adatum\Adminstrator'
$pwd22 = ConvertTo-SecureString "Pa55w.rd" -AsPlainText -Force
$cred22 = New-Object System.Management.Automation.PSCredential ($user22, $pwd22)
$cred22 | Export-Clixml C:\Backup\cred22.txt

$ujcred = Import-Clixml C:\Backup\cred22.txt
