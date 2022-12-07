$lista = Get-ADUser -Filter *
for ($i=1; $i -le 10; $i++) {
 Write-Host $lista[$i].Name
}


for ($i=1; $i -le 20; $i++) {
    Write-Host $i
    if ($i -eq 14) { Break } 
    else { Continue }
}


$valasz = $false
$j = 0
Do {
    Write-Host $j
    if ($j -ge 20) { $valasz = $false }
    $j++
} While ($valasz)


$valasz = $false
$j = 0
Do {
    Write-Host $j
    if ($j -ge 20) { $valasz = $true }
    $j++
} Until ($valasz)