
$ComputerList = @{ "BD71-CIM6" = "10.0.55.44"}
$PasswordHash = @{
                    "testUser" = "@sshat2013!";

                    } 
$creds = get-credential


foreach ($computer in $ComputerList) {
echo $computer.Values
$tempAccList = Get-WmiObject -Class Win32_UserAccount -Namespace "root\cimv2" ` -Filter "LocalAccount='$True'" -ComputerName $computer.Values -Credential $creds -ErrorAction Stop | where { $PasswordHash.Contains($_.Name) } 
$tempAccList

foreach ($account in $tempAccList ) { 
    echo $account.name

    ([adsi]("WinNT://" + $computer + "/" + $account.name +", user")).setpassword($passwordHash[$account.name])
    
    }

}