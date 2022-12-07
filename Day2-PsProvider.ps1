Get-PSProvider
Get-PSDrive

$lonsrv1webroot = '\\lon-svr1\c$\inetpub\wwwroot'
New-PSDrive -Name lonweb -Root $lonsrv1webroot -PSProvider FileSystem
New-PSDrive -Name X -Root $lonsrv1webroot -PSProvider FileSystem -Persist
Remove-PSDrive -Name X

Get-ChildItem | Select-Object Name, LastAccessTime, LastWriteTime, CreationTime, DirectoryName

#NtfsDisableLastAccessUpdate
Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem -Name NtfsDisableLastAccessUpdate
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem -Name NtfsDisableLastAccessUpdate -Value 0
