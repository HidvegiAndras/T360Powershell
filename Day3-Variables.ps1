Get-ChildItem variable:
Get-Variable

[string]$szam = 67
$szam.GetType()
$szam.Length

[int]$num3 = $szam
$num3.GetType()

# String

$string1 = "Hello szia szevasz"
$string1.GetType()
$string1 | gm
$string1.Length
$string1.ToLower()

$string1.Contains("a s")
$string1 = $string1.Insert(6,"viszlát ")
$string1.Replace(" ","-")
$string1.Split(" ")

$path1 = 'C:\inetpub\wwwroot'
$path1.Split("\") | Select -Last 1
$path2 = Get-Location
($path2.Path).Split("\") | Select -Last 1

$string2 = " csáó"
$string1 + $string2 + "még valami"
$string3 = "Köszöntések: $string1"+$num2
$string3 = "Köszöntések: $string1 $szam"

# string boolean értéke
$string4 = ""
$string4.Length
$string4 = $null
$string4.GetType()

if ($string4) {
    # igaz
    Write-Host "van"
}
else {
    # hamis
    Write-Host "nincs"
}

# Numerikus típusok

$num1 = 5
$num1 | Get-Member
$num1.GetType()

Set-Variable -Name num2 -Value 10 
$num2
$num1 * $num2

# Dátum típus
$dat1 = Get-Date
$dat1.GetType()
$dat1 | select *

# Boolean
$true
$false

$dontes = 100 -eq 100
$dontes.GetType()

# Null érték
$null
$nullertek = $null
