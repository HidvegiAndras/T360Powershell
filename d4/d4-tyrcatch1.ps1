$comp = "Lon-dc1, Lon-svr1"
Try {
    Get-WmiObject –Class Win32_BIOS –ComputerName $comp –ErrorAction Stop
} 
Catch {
    Write-Host “Error connecting to $comp”
} 
Finally {
    Write-Host “BIOS query for $comp is complete”
}

