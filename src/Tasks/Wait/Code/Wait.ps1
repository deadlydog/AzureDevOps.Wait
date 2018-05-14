param
(
	[parameter(Mandatory=$true,HelpMessage="The units (milliseconds, seconds, or minutes) that the provided Value is in.")]
	[ValidateSet('milliseconds', 'seconds', 'minutes')]
	[string] $Unit,

	[parameter(Mandatory=$true,HelpMessage="The number of units to wait for.")]
	[int] $Value
)

Process
{
	[int] $millisecondsToSleepFor = Convert-UnitToMilliseconds -Unit $Unit -Value $Value

	Write-Output "About to wait for $Value $Unit..."
	Start-Sleep -Milliseconds $millisecondsToSleepFor
	Write-Output "Finished waiting for $Value $Unit."
}

Begin
{
	$THIS_SCRIPTS_DIRECTORY_PATH = Split-Path $script:MyInvocation.MyCommand.Path
	$convertUnitModuleFilePath = Join-Path -Path $THIS_SCRIPTS_DIRECTORY_PATH -ChildPath 'Convert-Unit.psm1'
	Import-Module -Name $convertUnitModuleFilePath
}