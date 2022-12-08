Write-Host "1. dátum"
Write-Host "2. Aduserek"
Write-Host "3. Rakéta indítás"
$ertek = "Szia"
$valasz = Read-Host "$ertek mia a válasz"

Switch ($valasz) {
    "1" {Get-Date}
    "2" {Get-ADUser}
    "3" {Write-Host "Ez a feature még fejelsztés alatt"}
}

[int]$valasz = Read-Host "$ertek mia a válasz