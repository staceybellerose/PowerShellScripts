function Get-HelpMatch {
<#
.Synopsis
    Search the PowerShell help documentation for a given keyword or regular expression.
.Description
    Search the PowerShell help documentation for a given keyword or regular expression.
#>
    param($searchWord = $(throw "Please specify content to search for"))

    $helpNames = $(Get-Help *)

    foreach($helpTopic in $helpNames)
    {
        $content = Get-Help -Full $helpTopic.Name | Out-String
        if($content -match $searchWord)
        {
            $helpTopic | Select-Object Name,Synopsis
        }
    }
}
