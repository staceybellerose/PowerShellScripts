function Set-LocationAlias {
	[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact="Low")]
	param (
		[string]$Name=$(throw "A name is required for the location"),
		$Path=$pwd
	)

	if ($PSCmdlet.ShouldProcess($Name, "Create location function")) {
		Set-Variable -Name $Name -Value "$([string]$Path)" -Scope global
		Invoke-Expression "function global:Push-Location_$Name{Push-Location `$$Name}"
		Set-Alias -Name $Name -Value "Push-Location_$Name" -Scope global
	}
}
