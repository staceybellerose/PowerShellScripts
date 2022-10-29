##
## Handy string utilities.
##

# cuts text lines into fields
function cut([int[]] $indices, [string[]] $names, [bool] $keepLast=$true, [bool] $trim=$true) {
<#
.Synopsis
	Slices text lines into fields.
.Description
	Given the indices for how to break up a string, cut will output a list of
	objects with fields matching the specified names. Each field runs until the
	next field, or in the case of the final field, the end of the input line.
.Parameter indices
	Takes a list of indices at which each field will start.
.Parameter names
	A list of names for each output field
.Parameter keepLast
	If false, the last field in each line will be discarded.
.Parameter trim
	if false, the fields will not be trimmed.
.Example
	echo "1    value" | cut 0,5 Id,Data
	Description
	-----------
	Returns an object with $_.Id and $_Data fields.
#>
	begin
	{
		[int]$local:length = $indices.length
		if(!$keepLast -and $length -eq 0)
		{
			if($length -gt 1) { $length-- }
		}
		if($null -eq $names -or $names.length -ne $length)
		{
			throw "The number of names must be equal in number to the fields ($length)."
		}
	}

	process
	{
		if($null -eq $indices -or $indices.length -eq 0)
		{
			if($trim)
			{
				return ([string]$_).Trim()
			}
			else
			{
				return $_
			}
		}
		else
		{
			if(!$keepLast -and $length -eq 0)
			{
				return ''
			}

			[string]$local:str = $_;
			[int]$local:strLength = $str.length

			$local:output = 0 | select-object $names
			for($local:i=0; $i -lt $length; $i++)
			{
				[int]$local:start = $indices[$i]
				if($start -gt $strLength)
				{
					$start = $strLength
				}

				if($i -eq $indices.length-1)
				{
					[int]$local:end = $strLength
				}
				else
				{
					[int]$local:end = $indices[$i+1]
				}

				if($end -gt $strLength)
				{
					$end = $strLength
				}

				$local:field = $str.Substring($start, $end-$start)

				if($trim)
				{
					$field = $field.Trim()
				}

				$output.($names[$i]) = $field
			}

			return $output
		}
	}
}

# joins a number of items with a separator
function join([string] $sep, [string[]] $items) {
<#
.Synopsis
	Joins a number of items with a separator.
.Description
	Joins a number of items with a separator.  This is needed because .NET
	argument binding in PoSH will fail will empty or single-item lists
.Parameter sep
	String to use as an item separator
.Parameter items
	A list of items to join together
.Example
	join ':' (1,2,3)
	Description
	-----------
	Returns "1:2:3"
.Example
	join ':' 1
	Description
	-----------
	Returns "1" (this would fail with [string]::Join)
.Example
	join ':' ("0:1:2".split(':') | ? { $_ -gt 0 })  # produces "1:2"
	Description
	-----------
	Returns "1:2"
#>
	if ($null -eq $items) { return '' }
	return [string]::Join($sep, $items)
}

# truncates a string at a given length. if the string is longer than the given length,
# an ellipsis will be added to the end
function truncateStringAt([string] $str, [int] $length) {
<#
.Synopsis
	Truncates a string at a given length, with ellipsis added for longer strings.
.Parameter str
	The string to truncate
.Parameter length
	The lenght of the final truncated string
.Example
	truncateStringAt "Really Long String" 10
	Description
	-----------
	Returns "Really ..."
#>
	if($length -lt 0) { throw 'Length cannot be negative.' }

	if($str.length -gt $length)
	{
		if($length -gt 3)
		{
			$str = $str.substring(0, $length-3) + "..."
		}
		else
		{
			$str = $str.substring(0, $length)
		}
	}

	return $str
}

Export-ModuleMember -Function @("cut", "join", "truncateStringAt")
