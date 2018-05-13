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
	[int] $millisecondsToSleepFor = Convert-UnitToMilliseconds -Unit $Unit -Value $Value

	Write-Output "About to sleep for $Value $Unit..."
	Start-Sleep -Milliseconds $millisecondsToSleepFor
	Write-Output "Finished sleeping for $Value $Unit."
}

Begin
{
	function Convert-UnitToMilliseconds
	{
		param
		(
			[parameter(Mandatory=$true,HelpMessage="The units (Milliseconds, Seconds, or Minutes) that the provided Value is in.")]
			[ValidateSet('Milliseconds', 'Seconds', 'Minutes')]
			[string] $Unit,

			[parameter(Mandatory=$true,HelpMessage="The number of units to wait for.")]
			[int] $Value
		)

		[int] $milliseconds = 0
		switch ($Unit)
		{
			'Milliseconds' { $milliseconds = $Value }
			'Seconds' { $milliseconds = (Convert-SecondsToMilliseconds -seconds $Value) }
			'Minutes' { $milliseconds = (Convert-MinutesToMilliseconds -minutes $Value) }
		}
		return $milliseconds
	}

	function Convert-SecondsToMilliseconds([int] $seconds)
	{
		return $seconds * 1000
	}

	function Convert-MinutesToMilliseconds([int] $minutes)
	{
		return $minutes * 60 * 1000
	}
}