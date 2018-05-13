param
(
	[parameter(Mandatory=$true,HelpMessage="The units (Seconds or Minutes) that the provided Value is in.")]
	[ValidateSet('Seconds', 'Minutes')]
	[string] $Unit,

	[parameter(Mandatory=$true,HelpMessage="The number of units to wait for.")]
	[int] $Value
)

Process
{
	[int] $secondsToSleepFor = $Value
	if ($Unit -ieq 'Minutes')
	{
		$secondsToSleepFor = $Value * 60
	}

	Write-Output "About to sleep for $secondsToSleepFor seconds..."
	Start-Sleep -Seconds $secondsToSleepFor
	Write-Output "Finished sleeping for $secondsToSleepFor seconds."
}