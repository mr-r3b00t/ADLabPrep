
$OUPath = "OU=New York,DC=DemoLab,DC=local"
$salt = "Demolab"
$userdetails = get-content .\Users.txt
$Departments = Get-Content .\department.txt

$passwords = Get-Content .\10-million-password-list-top-1000.txt

foreach($object in $userdetails){

write-host $object

$detailsArray =$object.Split(",")


$name = $detailsArray[0]
$Firstname = $detailsArray[1]
$Lastname = $detailsArray[2]
$UserName = $detailsArray[3]
$DepartmentName = Get-Random -InputObject $Departments

#foreach($item in $detailsArray){
#write-host $item
#}


write-host $name -ForegroundColor Cyan
write-host $Firstname -ForegroundColor Cyan
write-host $Lastname -ForegroundColor Cyan
write-host $UserName -ForegroundColor Cyan
write-host $DepartmentName -ForegroundColor Cyan

$newPass = Get-Random -InputObject $passwords

write-host $newPass -ForegroundColor Red

write-host "Converting Password to secure string" -ForegroundColor Green
$newPass = $salt + $newPass
$securePass = ConvertTo-SecureString $newPass -AsPlainText -Force
write-host $securePass.Length

#Create a new User Object in ADDS

New-ADUser -Name $name -GivenName $Firstname -Surname $Lastname -SamAccountName $UserName -Path $OUPath -AccountPassword $SecurePass -Enabled $true -Description $DepartmentName
}
