#Random Computer Account Generator
$OUPath = "OU=Computers,OU=HQ,DC=Demolab,DC=local"
$Prefix = "SRV-PROD-"

1..500 | % { write "loop $_" 

$servername = $Prefix + $_

write-host $servername
#clearly u can do some funky with readin in a file with the OS version data in to make it pick radom OS versions etc. this is just saying 2008 R2 SP1
New-ADComputer -Name $servername -SamAccountName $servername -Path $OUPath -OperatingSystem "Windows Server 2008 R2 Datacenter" -OperatingSystemVersion "6.1 (7601)" -OperatingSystemServicePack "Service Pack 1"

}

