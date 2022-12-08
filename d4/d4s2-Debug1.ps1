Param(
    [Parameter(Mandatory)]
    [string]$computername,

    [Parameter()]
    [int]$szam = 10,
    [int]$szam2 = 20
)
Get-Process -ComputerName $computername
$szam + $szam2

#Set-PSBreakpoint -Script .\d4s2-Debug1.ps1 -Command "Get-Process"
#Get-PSBreakpoint -Script .\d4s2-Debug1.ps1