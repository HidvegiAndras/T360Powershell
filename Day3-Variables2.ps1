$szervizek = Get-Service
$szervizek[-1]

# Array

$tomb1 = @(1,2,3,4,5,6,7)
$tomb3 = @(10,20,30,40,50)
$tomb2 = @("Hello", "Szia", "Szevasz")
$tomb1.GetType()
$tomb1[-1]
$tomb1.Count
$tomb1[2..5]
$tomb1[-3..-1]
$a = 30..50

$tomb1 + $tomb3
$matrix = @( @(1,2,3), @(5,6,7) )
$matrix[1][0]
1 2 3
4 5 6 

# Hash táblák

$hash1 = @{“LON-DC1” = ”172.16.0.10”; “LON-SRV1” = ”172.16.0.11”}
$hash1["LON-SRV1"]

$hash1.Add("ujertek", 132)
$hash1.Remove("Lon-dc1")



# AD User lekérdezés formázás hash tábla segítésével
Get-ADUser -Properties * -Filter * |  
    Select-Object @{Label = "First Name";Expression = {$_.GivenName}},  
    @{Label = "Last Name";Expression = {$_.Surname}}, 
    @{Label = "Display Name";Expression = {$_.DisplayName}}, 
    @{Label = "Logon Name";Expression = {$_.sAMAccountName}}, 
    @{Label = "Full address";Expression = {$_.StreetAddress}}, 
    @{Label = "City";Expression = {$_.City}}, 
    @{Label = "State";Expression = {$_.st}}, 
    @{Label = "Post Code";Expression = {$_.PostalCode}}, 
    @{Label = "Country/Region";Expression = {if (($_.Country -eq 'GB')  ) {'United Kingdom'} Else {''}}}, 
    @{Label = "Job Title";Expression = {$_.Title}}, 
    @{Label = "Company";Expression = {$_.Company}}, 
    @{Label = "Description";Expression = {$_.Description}}, 
    @{Label = "Department";Expression = {$_.Department}}, 
    @{Label = "Office";Expression = {$_.OfficeName}}, 
    @{Label = "Phone";Expression = {$_.telephoneNumber}}, 
    @{Label = "Email";Expression = {$_.Mail}}, 
    @{Label = "Manager";Expression = {%{(Get-AdUser $_.Manager -server $Server -Properties DisplayName).DisplayName}}}, 
    @{Label = "Account Status";Expression = {if (($_.Enabled -eq 'TRUE')  ) {'Enabled'} Else {'Disabled'}}}, # the 'if statement# replaces $_.Enabled 
    @{Label = "Last LogOn Date";Expression = {$_.lastlogondate}} | Out-File c:\Backup\ad1.txt


# Új VM hash táblában tárolt paraméterekből

$newVMhash = @{ 
 Name="ujvmfromhash" 
 SwitchName="Private Network"
 MemoryStartupBytes=2GB
 Path="C:\demovm"
 NewVHDPath="C:\demovm\demovmdisk1.vhdx"
 NewVHDSizeBytes=40GB 
 ErrorAction="Stop" 
} 

$VM = New-VM @newVmhash
