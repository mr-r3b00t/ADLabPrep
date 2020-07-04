
$OUPath = "OU=New York,DC=DemoLab,DC=local"
$salt = "Demolab"
$userdetails = get-content .\Users.txt
$Departments = Get-Content .\department.txt

$passwords = Get-Content .\10-million-password-list-top-1000.txt

#trim the samaccountname down
# thanks to dude here https://stackoverflow.com/questions/2336435/powershell-how-to-limit-string-to-n-characters
#lazy mRr3b00t
function Trim-Length {
param (
    [parameter(Mandatory=$True,ValueFromPipeline=$True)] [string] $Str
  , [parameter(Mandatory=$True,Position=1)] [int] $Length
)
    $Str[0..($Length-1)] -join ""
}





foreach($object in $userdetails){

write-host $object

$detailsArray =$object.Split(",")


$name = $detailsArray[0]
$Firstname = $detailsArray[1]
$Lastname = $detailsArray[2]
$UserName = $detailsArray[3]
$DepartmentName = Get-Random -InputObject $Departments


#ok self - the samaccountname can't be longer than 14 so... make it so number 1
$test = $UserName

if($test.Length -ge 15){

$UserName = $test | Trim-Length 14

write-host $UserName
}
else{
write-host "It's find dude the name is the right size!"
}



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
