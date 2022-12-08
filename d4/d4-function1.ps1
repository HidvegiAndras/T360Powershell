Function Calculate-SumNumbers {
    Param (
    [int]$szam1 = 0,
    [int]$szam2 = 0
    )
    Return($szam1 + $szam2)
}

$r = Calculate-SumNumbers -szam1 10 -szam2 20

# -------------------------------------------------------

Function Calculate-DivideNumbers {
    Param (
    [int]$szam1 = 0,
    [int]$szam2 = 0
    )
    Try { Return($szam1 / $szam2) }
    Catch { $Error[0] }
}


$r2 = Calculate-DivideNumbers -szam1 5 -szam2 0

# --------------------------------------------------------
 
Function Get-SecurityEvent {
    Param (
    [string]$ComputerName
    ) #end Param

    Get-EventLog -LogName Security -ComputerName $ComputerName -Newest 10
}

$r3 = Get-SecurityEvent -ComputerName LON-DC1
