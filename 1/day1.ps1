$Data = Get-Content .\input.txt

# convert to string to make it easy to split
$DataString = $Data -join ','

# split on ',,' for the empty lines
$DataParsed = $DataString -split ',,'

# work out totals and add to array
[array]$Output = @()
foreach ($DataParsedLine in $DataParsed) {
    [array]$Output += ($DataParsedLine -split ',') | Measure-Object -Sum | Select-Object -ExpandProperty Sum
}

# pt1 return highest value
Write-Output "Pt1: $(($Output | Sort-Object -Descending)[0])"

# pt2 return sum of top 3 values
$Sum = ($Output | Sort-Object -Descending)[0..2] | Measure-Object -Sum | Select-Object -ExpandProperty Sum
Write-Output "Pt2: $($Sum)"
