$THIS_SCRIPTS_PATH = $PSCommandPath
$filePathToTest = $THIS_SCRIPTS_PATH.Replace('.Tests.ps1', '.psm1')
Write-Verbose "Dot-sourcing the file '$filePathToTest' to run tests against it." -Verbose
Import-Module -Name $filePathToTest -Force

Describe 'Convert-UnitToMilliseconds' {
	It 'Should convert seconds properly' {
		$milliseconds = Convert-UnitToMilliseconds -Unit 'seconds' -Value 2
		$milliseconds | Should -Be 2000
	}

	It 'Should convert minutes properly' {
		$milliseconds = Convert-UnitToMilliseconds -Unit 'minutes' -Value 2
		$milliseconds | Should -Be 120000
	}
}

Describe 'Convert-SecondsToMilliseconds' {
	It 'Should convert 2 seconds to 2000 milliseconds' {
		$milliseconds = Convert-SecondsToMilliseconds -seconds 2
		$milliseconds | Should -Be 2000
	}
}

Describe 'Convert-MinutesToMilliseconds' {
	It 'Should convert 2 minutes to 120000 milliseconds' {
		$milliseconds = Convert-MinutesToMilliseconds -minutes 2
		$milliseconds | Should -Be 120000
	}
}