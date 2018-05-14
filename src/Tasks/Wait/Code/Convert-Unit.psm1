function Convert-UnitToMilliseconds
{
	param
	(
		[parameter(Mandatory=$true,HelpMessage="The units (milliseconds, seconds, or minutes) that the provided Value is in.")]
		[ValidateSet('milliseconds', 'seconds', 'minutes')]
		[string] $Unit,

		[parameter(Mandatory=$true,HelpMessage="The number of units to wait for.")]
		[int] $Value
	)

	[int] $milliseconds = 0
	switch ($Unit)
	{
		'milliseconds' { $milliseconds = $Value }
		'seconds' { $milliseconds = (Convert-SecondsToMilliseconds -seconds $Value) }
		'minutes' { $milliseconds = (Convert-MinutesToMilliseconds -minutes $Value) }
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

Export-ModuleMember -Function Convert-UnitToMilliseconds
Export-ModuleMember -Function Convert-SecondsToMilliseconds
Export-ModuleMember -Function Convert-MinutesToMilliseconds