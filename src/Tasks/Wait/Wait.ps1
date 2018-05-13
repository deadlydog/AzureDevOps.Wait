param
(
	[parameter(Mandatory=$true,HelpMessage="The units (Milliseconds, Seconds, or Minutes) that the provided Value is in.")]
	[ValidateSet('Milliseconds', 'Seconds', 'Minutes')]
	[string] $Unit,

	[parameter(Mandatory=$true,HelpMessage="The number of units to wait for.")]
	[int] $Value
)

Process
{
	[int] $millisecondsToSleepFor = 0
	switch ($Unit)
	{
		'Milliseconds' { $millisecondsToSleepFor = $Value }
		'Seconds' { $millisecondsToSleepFor = ($Value * 1000) }
		'Minutes' { $millisecondsToSleepFor = ($Value * 1000 * 60) }
	}

	Write-Output "About to sleep for $Value $Unit..."
	Start-Sleep -Milliseconds $millisecondsToSleepFor
	Write-Output "Finished sleeping for $Value $Unit."
}