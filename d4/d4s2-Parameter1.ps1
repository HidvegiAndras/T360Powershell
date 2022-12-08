Param(
    [Parameter(Mandatory)]
    [string]$computername,

    [Parameter()]
    [int]$szam = 10,
    [int]$szam2 = (Read-Host "Második szám: ")
)
Get-Process -ComputerName $computername
$szam + $szam2