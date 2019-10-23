[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation
try
{
	# Get task variables.
	[bool] $debug = Get-VstsTaskVariable -Name System.Debug -AsBool

	# Get the inputs.
	[string] $unit = Get-VstsInput -Name Unit -Require
	[int] $value = Get-VstsInput -Name Value -AsInt -Require

	# Invoke the script to do the actual work.
	$scriptFilePath = Join-Path -Path $PSScriptRoot -ChildPath 'Code\Wait.ps1'
	& $scriptFilePath -Unit $unit -Value $value
}
finally
{
	Trace-VstsLeavingInvocation $MyInvocation
}
