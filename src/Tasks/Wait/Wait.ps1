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

	Write-Output "About to wait for $Value $Unit..."
	Start-Sleep -Milliseconds $millisecondsToSleepFor
	Write-Output "Finished waiting for $Value $Unit."
}

Begin
{
	$THIS_SCRIPTS_DIRECTORY_PATH = Split-Path $script:MyInvocation.MyCommand.Path
	$tasksDirectoryPath = Split-Path -Path $THIS_SCRIPTS_DIRECTORY_PATH -Parent
	$srcDirectoryPath = Split-Path -Path $tasksDirectoryPath -Parent
	$codeDirectoryPath = Join-Path -Path $srcDirectoryPath -ChildPath 'code'
	$convertUnitModuleFilePath = Join-Path -Path $codeDirectoryPath -ChildPath 'Convert-Unit.psm1'

	Import-Module -Name $convertUnitModuleFilePath
}