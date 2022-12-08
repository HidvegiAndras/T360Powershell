<#
.SYNOPSIS
  Próba help teszt
.DESCRIPTION
  This script will <Elaborate on what the script does>
.PARAMETER Param1
  Specifies <What? Is the parameter required?>
  Computername
  Szam
  Szam2
.INPUTS
  <Does the script accept an input>
.OUTPUTS
  A log file in the temp directory of the user running the script
.NOTES
  Version:        0.1
  Author:         Hidvégi András
  Creation Date:  <Date>
  Purpose/Change: Initial script development
.EXAMPLE
  d4s2-fromtemplate.ps1 -computername 
  d4s2-fromtemplate.ps1 -computername x y
#>

#requires -version 5.1

#-----------------------------------------------------------[Parameters]-----------------------------------------------------------
Param(
    [Parameter(Mandatory)]
    [string]$computername,

    [Parameter()]
    [int]$szam = 10,
    [int]$szam2 = (Read-Host "Második szám: ")
)
#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#-----------------------------------------------------------[Functions]------------------------------------------------------------

#-----------------------------------------------------------[Execution]------------------------------------------------------------
$bios = Get-WmiObject Win32_BIOS -ComputerName $ComputerName
Write-Host $bios
$szam + $szam2
#-----------------------------------------------------------[Finish up]------------------------------------------------------------