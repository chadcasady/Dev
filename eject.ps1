<#
.SYNOPSIS
	Ejects one or more disc drives.
.DESCRIPTION
	The Eject-DiscDrive cmdlet will eject all disc drives on a local or remote computer or computers.
	
	Eject-DiscDrive requires that Windows Remote Management is enabled.
.PARAMETER ComputerName
	The name of the computer that you would like to gather information about. Defaults to the local computer. It will accept a comma delimited list.
.EXAMPLE
	Eject-DiscDrive CEO-01,BOSS-01
	
	This will eject the disc drives on both the CEO-01 computer and the BOSS-01 computer.
.INPUTS
	The name of the computer(s).
.OUTPUTS
.LINK
	WinRM: Enable-PSRemoting
	Shell.Application
#>
Function Eject-DiscDrive
{
	Param
	(
		[string[]]$computerName = $env:COMPUTERNAME
	)
	Begin{}
	Process
	{
		ForEach($computer in $computerName)
		{
			If($computer -eq $env:COMPUTERNAME)
			{
				$sh = New-Object -ComObject "Shell.Application"
				$items = $sh.namespace(17).Items()
				ForEach($item in $items)
				{
					If($item.type -eq "CD Drive")
					{
						$item.InvokeVerb("Eject")
					}
				}
			}
			Else
			{
				Invoke-Command -ComputerName $computer -ScriptBlock {
					$sh = New-Object -ComObject "Shell.Application"
					$items = $sh.namespace(17).Items()
					ForEach($item in $items)
					{
						If($item.type -eq "CD Drive")
						{
							$item.InvokeVerb("Eject")
						}
					}
				}
			}
		}
	}
	End{}
}