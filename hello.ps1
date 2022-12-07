# Write-Host "Hello World"
$filelist = Get-ChildItem C:\Backup -Recurse 

foreach ($aktualislistaelem in $filelist) {
    if ($aktualislistaelem.Attributes -eq 'Directory') {
        Write-Host "Ez 1 könyvtár:" $aktualislistaelem.Fullname $aktualislistaelem.Length
    }
    elseif($aktualislistaelem.Length -gt 1000) {
        Write-Host "Ez 1 nagy fájl: " $aktualislistaelem.Fullname $aktualislistaelem.Length
    }
    else {
        Write-Host "Ez 1 kis fájl: " $aktualislistaelem.Fullname $aktualislistaelem.Length
    }
}