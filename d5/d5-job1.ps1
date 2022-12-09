$mindenfajl = Get-ChildItem -Path 'c:\' -Recurse

# Jobok

Get-Command -Noun Job
Get-Job
Get-Job | Select -ExpandProperty ChildJobs | FL
#
# Local job

Start-Job -Scriptblock { Get-ChildItem -Path 'c:\' -Recurse } -name LocalDirectory
Start-Job -ScriptBlock { Dir C:\ -Recurse } -Name LocalDirectory2
Start-Job -FilePath ".ps1" -Name Scriptjob

Stop-Job -Id 4
Resume-Job -Name LocalDirectory
Remove-Job -Name LocalDirectory

# Remote Job
Invoke-Command -ScriptBlock {Get-EventLog -LogName System -Newest 10} `
    -ComputerName LON-DC1,LON-CL1,LON-SVR1 -AsJob -JobName RemoteLogs

#CMI/WMI Job
Start-Job -ScriptBlock {Get-CimInstance -ClassName Win32_ComputerSystem}

# Elkészült-e a job
# wait-Job

Get-Help Wait-Job -Full
Invoke-Command -ScriptBlock {Get-EventLog -LogName System -Newest 10} `
    -ComputerName LON-DC1,LON-CL1,LON-SVR1 -AsJob -JobName RemoteLogs2

Write-Host 'Azonnal'
# Receive-Job -Name RemoteLogs2 -Keep

Wait-Job -Name RemoteLogs2

Write-Host 'megvártam'
Receive-Job -Name RemoteLogs2 -Keep


# Hogyan kapom vissza az adatokat
Get-Job

$adatok = Receive-Job -Name RemoteLogs -Keep #-keep-el megőrzi
$masikjob = Receive-Job -Id 12
$joblocaldir = Receive-Job -Id 6 -Keep
$joblocaldir.Count

Debug-Job -Id 14
Stop-Job -id 14
Remove-Job -id 14
