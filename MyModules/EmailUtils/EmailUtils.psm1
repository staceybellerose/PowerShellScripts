##
## Email Utilities
##

function Send-Email([Parameter(Mandatory)][String] $credentialsFilePath,
	[Parameter(Mandatory)][Net.Mail.MailMessage] $mailMessage,
	[Parameter(Mandatory)][String] $smtpServer,
	[Parameter(Mandatory)][Int] $smtpPort,
	[Switch] $enableSsl) {
<#
.Synopsis
	Send an email message
.Description
	Send an email message, using the credentials provided to communicate
	with the specified mail server.
.Parameter credentialsFilePath
	The full path of the file where the credentials are stored.
	If only a file name is provided, the current directory will be used.
.Parameter mailMessage
	A fully-formed Net.Mail.MailMessage object containing the message to send.
	This should be build using Set-MailMessage.
.Parameter smtpServer
	The mail server with which to communicate.
.Parameter smtpPort
	The TCP port to use when communicating with the smtp server.
.Parameter enableSsl
	Whether or not to enable SSL communication with the smtp server.
#>
	$smtpCredentials = Read-EmailCredentials $credentialsFilePath
	$smtpclient = New-Object net.mail.smtpclient($smtpServer, $smtpPort)
	$smtpclient.EnableSsl = $enableSsl
	$smtpclient.Credentials = $smtpCredentials.GetNetworkCredential()
	$smtpclient.send($mailMessage)
}

function Set-MailMessage(
	[Parameter(Mandatory)][String] $subject,
	[Parameter(Mandatory)][String] $body,
	[Parameter(Mandatory)][String] $from,
	[Parameter(Mandatory)][String[]] $to,
	[AllowNull()][String[]] $cc,
	[AllowNull()][String[]] $bcc,
	[switch] $isBodyHtml) {
<#
.Synopsis
	Create an email message
.Description
	Create an email message to be sent via SMTP
.Parameter subject
	The subject line of the message
.Parameter body
	The body of the message
.Parameter from
	Email address of the person the message is from
.Parameter to
	Array of email addresses of the people to which the message is to be sent
.Parameter cc
	Array of email addresses of the people to which the message is to be courtesy-copied
.Parameter cc
	Array of email addresses of the people to which the message is to be blind-courtesy-copied
.Parameter isBodyHtml
	A flag to indicate whether the message body is in HTML format or is plain text
#>
	$mail = New-Object Net.Mail.MailMessage
	$mail.From = $from
	foreach ($address in $to) {
		$mail.To.Add($address)
	}
	foreach ($address in $cc) {
		$mail.CC.Add($address)
	}
	foreach ($address in $bcc) {
		$mail.Bcc.Add($address)
	}
	$mail.Subject = $subject
	$mail.Body = $body
	$mail.IsBodyHtml = $isBodyHtml
	return $mail
}

function Read-EmailCredentials([Parameter(Mandatory)][String] $filePath) {
<#
.Synopsis
	Read the user's email credentials
.Description
	Read the user's email credentials from a file
.Parameter filePath
	The full path of the file where the credentials are stored.
	If only a file name is provided, the current directory will be used.
#>
	$credentialContents = Get-Content $filePath
	$user = $credentialContents[0]
	$password = $credentialContents[1] | ConvertTo-SecureString
	$MyCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $password
	return $MyCredential
}

function Save-EmailCredentials([Parameter(Mandatory)][String] $filePath) {
<#
.Synopsis
	Save the user's email credentials
.Description
	Prompt the user for their email credentials and store them securely
.Parameter filePath
	The full path of the file where the credentials should be stored.
	If only a file name is provided, the current directory will be used.
#>
	$MyCredential = Get-Credential
	$MyCredential.Username | Out-File $filePath
	$MyCredential.Password | ConvertFrom-SecureString | Out-File $filePath -Append
}

Export-ModuleMember -Function @("Send-Email", "Set-MailMessage", "Read-EmailCredentials", "Save-EmailCredentials")
