function p {
    param($computername)
    return (test-connection $computername -Count 1 -quiet)
}

# -----------------------------------------------------
# Function Name: Get-LoggedIn
# Return the current logged-in user of a remote machine
# Author: Nur
# -----------------------------------------------------
function Get-LoggedIn {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)]
        [string[]]$computername
    )

    foreach ($pc in $computername){
        $logged_in = (gwmi win32_computersystem -COMPUTER $pc).username
        $name = $logged_in.split("\")[1]
        "{0}: {1}" -f $pc,$name
    }
}


function Get-Uptime {
    [CmdletBinding()]
    param (
        [string]$Computername = 'localhost'
    )

    foreach ($Computer in $Computername){
        $pc = $Computername
        $os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $Computername
        $diff = $os.ConvertToDateTime($os.LocalDateTime) - $os.ConvertToDateTime($os.LastBootUpTime)

        $properties=@{
            'ComputerName'=$pc;
            'UptimeDays'= $diff.Days;
            'UptimeHours' = $diff.Hours;
            'UptimeMinutes' = $diff.Minutes
            'UptimeSeconds' = $diff.Seconds
        }
        $obj = New-Object -TypeName psobject -Property $properties

        Write-Output $obj
    }
}




