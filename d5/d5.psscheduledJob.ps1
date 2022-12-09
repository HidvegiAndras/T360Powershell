Get-Command –Module ScheduledTasks
Get-ScheduledTask
Get-ScheduledTaskInfo -TaskName CreateExplorerShellUnelevatedTask
Get-ScheduledTaskInfo -TaskName "Delete Disabled User from Managers Security Group" | select *

Get-ScheduledTask -TaskPath "\Microsoft\Windows\WindowsUpdate\" | Get-ScheduledTaskInfo

Get-ADUser -SearchBase "OU=Managers,DC=Adatum,DC=com" -Filter {Enabled -eq $false}
Get-ADUser -Filter { SamAccountName -eq "William" }

# 
Get-Command –Module PSScheduledJob
Get-Job

$opt = New-ScheduledJobOption -WakeToRun
$trigger2 = New-JobTrigger –Once –At (Get-Date).AddMinutes(2)
# $trigger2 = New-ScheduledTaskTrigger -Once –At (Get-Date).AddMinutes(2)
Register-ScheduledJob -Trigger $trigger2 -ScheduledJobOption $opt `
    -ScriptBlock {Get-ChildItem c:\} -MaxResultCount 5 -Name Localdir-sj

Get-ScheduledJob

Get-ScheduledTask  -TaskName Localdir-sj

Get-Job
Receive-Job -Name Localdir-sj -Keep

# .........................................

# Open this file in the ISE. Highlight one line and press F8 to
# execute just that line. 

# 1
Import-Module PSScheduledJob
Get-Job | Remove-Job

# 2
$trigger3 = New-JobTrigger –Once –At (Get-Date).AddMinutes(1)

# 3
Register-ScheduledJob –Trigger $trigger3 –Name DemoJob –ScriptBlock { Get-EventLog –LogName Application }

# 4
Get-ScheduledJob | Select –Expand JobTriggers 
Unregister-ScheduledJob DemoJob
# notice the Time

# 5
Get-ScheduledJob 
# wait until after the time that was displayed in the previous step.

# 6
Get-Job
Receive-Job -Name DemoJob -Keep