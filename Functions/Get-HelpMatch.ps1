function Get-HelpMatch {
<#
.Synopsis
    Search the PowerShell help documentation for a given keyword or regular expression.
.Description
    Search the PowerShell help documentation for a given keyword or regular expression.
#>
    param($searchWord = $(throw "Please specify content to search for"))

    $helpNames = $(get-help *)

    foreach($helpTopic in $helpNames)
    {
       $content = get-help -Full $helpTopic.Name | out-string
       if($content -match $searchWord)
       { 
          $helpTopic | select Name,Synopsis
       }
    }
}
