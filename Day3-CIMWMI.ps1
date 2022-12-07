Get-WmiObject -Namespace root\CIMv2 -List
Get-CimClass -Namespace root\CIMv2
Get-WmiObject -class Win32_Processor -namespace root\CIMv2
Get-WmiObject -Namespace root -List -Recurse | Select -Unique __NAMESPACE

Get-CimClass *network*
Get-CimClass -ClassName Win32_NetworkAdapter

Get-CimInstance -ClassName WIN32_NetworkAdapter -ComputerName lon-cl1,lon-svr1


$computer = "lon-cl1"
$namespace = 'root\CIMV2'

$property = “systemname”,”maxclockspeed”,”addressWidth”,“numberOfCores”, “NumberOfLogicalProcessors”
Get-WmiObject -class win32_processor -Property  $property | Select-Object -Property $property

Get-WmiObject -Class BatteryStatus -Namespace $namespace 
Get-WmiObject -Class Win32_Processor -Namespace $namespace -ComputerName $computer

Get-WmiObject Win32_Processor -ComputerName $computer | Measure-Object -Property LoadPercentage -Average | Select Average 

Get-CimInstance -ClassName Win32_LogicalDisk -Filter "Drivetype = 3"

Get-CimInstance -Class CIM_LogicalDisk | Select-Object @{Name="Size(GB)";Expression={$_.size/1gb}}, @{Name="Free Space(GB)";Expression={$_.freespace/1gb}}, @{Name="Free (%)";Expression={"{0,6:P0}" -f(($_.freespace/1gb) / ($_.size/1gb))}}, DeviceID, DriveType 

Get-CimInstance -ClassName Win32_Fan
Get-CimInstance -ClassName Win32_DiskPartition
Get-CimInstance -ClassName win32_PhysicalMemory

Get-WmiObject -Class win32_PhysicalMemory -ComputerName $computer -Credential ADATUM\Administrator
 
# CIM Session

Get-CimSession
$cs1 = New-CimSession -ComputerName lon-cl1

$option1 = New-CimSessionOption -Protocol Dcom
$cs2 = New-CimSession -ComputerName lon-vr1 -SessionOption $option1

Get-Command -Noun CimSession
Remove-CimSession -ComputerName lon-cl1

Get-CimInstance -CimSession $cs1 -ClassName Win32_OperatingSystem


# Making changes 

Get-WmiObject -Class Win32_Service | Get-Member
Get-CimClass -ClassName Win32_Service | Select-Object -ExpandProperty Cimclassmethods
Get-CimClass -ClassName Win32_Service | Select-Object -ExpandProperty CimClassProperties | ft -AutoSize


Get-CimClass -ClassName Win32_Process | Select-Object -ExpandProperty Cimclassmethods
Invoke-CimMethod -ComputerName lon-cl1 -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine='notepad.exe'}
Get-CimInstance -ComputerName lon-cl1 -ClassName win32_Process -Filter "name='notepad.exe'" | Invoke-CimMethod -MethodName Terminate

Get-CimClass -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty Cimclassmethods

$ido1 = (Get-Date).AddHours(5)
Invoke-CimMethod -ClassName Win32_OperatingSystem -ComputerName lon-cl1 -MethodName SetDateTime -Arguments @{LocalDateTime=$ido1}
Invoke-CimMethod -ClassName Win32_OperatingSystem -ComputerName lon-cl1 -MethodName Reboot
