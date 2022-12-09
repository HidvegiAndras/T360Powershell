$string="Pa55w.rd"
$securePass = $string | ConvertTo-SecureString -AsPlainText -Force
$securePass = Read-Host "Password" -AsSecureString
$cred = New-Object System.Management.Automation.PSCredential ($userName, $secStringPassword)

# ----------------------------------------------------------

$array = @("Szia","Szevasz","Hello","Viszlát")

"Hello" -notin $array
$array -contains "*lo*"

"hidvegi.andras@training360.com" -match "^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"

"LON-DCSSCCC1" -match "LON-DC*1"
"1aa-1-1" -match "\d{1,3}-\d{1,3}-\d{1,3}"

# ----------------------------------------------------------

“File size: {0,10:f2}” -f 1.0782345
Write-Host (“File size: {0,10:f2}” -f 1.0782345)

"File name: {0,-20} File size: {1:n2,10}" -f "Test.txt",20023.34587

“{0,-20} {1,10}” -f “File Name”,”File Size”
"{0,-20} {1,10:c2}" -f "Test.txt",20023.34587
"Expense name: {0,-15} Cost: {1,12:c}" -f ”Dinner”,53.25
"{0,-20} {1,10:e}" -f "Test.txt",20023.34587
"{0,-20} {1,10:p}" -f "Test.txt",0.67
"{0,2:hh}:{0,2:mm}" -f (Get-Date)

# ----------------------------------------------------------

icacls.exe C:\Test /Grant Users(F)

icacls.exe --% C:\Test /Grant Users(F)

# -------------------------------------------------------------

Start-Transcript -Path C:\Backup\transcript22.txt 
Stop-Transcript -Path C:\Backup\transcript22.txt 

Write-EventLog -LogName "Application" -Source "MyApp" -EventID 3001 -EntryType Information -Message "MyApp added a user-requested feature to the display." -Category 1 -RawData 10,20

Get-eventlog -LogName Application | Select -First 1
Write-EventLog -LogName Application -EntryType Warning -Source "Windows Error Reporting" -EventId 10001 -Message "Profi log bejegyzés"

Get-EventLog | select Source
Get-WinEvent -LogName Application
$Error[0]

# ------------------------------------------------------

Get-SmbShare
New-SmbShare -Path "E:\Labfiles" -Name Labfiles -FullAccess Everyone

$acl = Get-Acl "E:\Labfiles" 
$acl.Access
$newrule = New-Object System.Security.AccessControl.FileSystemAccessRule("William", "ReadData", "Allow")
$acl.SetAccessRule($newrule)
$Acl | Set-Acl "E:\Labfiles" 


