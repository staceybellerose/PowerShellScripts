function ConvertFrom-Base64 {
	param (
		[string] $base64String
	)
	$bytes = [System.Convert]::FromBase64String($base64String)
	$decoded = [System.Text.Encoding]::UTF8.GetString($bytes)
	
	return $decoded
}
