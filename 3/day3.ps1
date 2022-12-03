# Functions
Function ConvertTo-Priority {
    param([char]$char)
    if ($char -cmatch "[A-Z]"){
        return ([int]([char]$char) - 38) # index is 38 above the given scoring
    }
    elseif ($char -cmatch "[a-z]"){
        return ([int]([char]$char) - 96) # index is 96 above the given scoring
    }
}

$Data = Get-Content .\input.txt

$Pt1Score = 0
Foreach ($Line in $Data) {
    # calc line length
    $Length = $Line.length
    $Items = ($Line[0..(($Length/2 - 1))]), $Line[($Length/2)..($Length - 1)]

    # get matching items
    Compare-Object -ReferenceObject $Items[0] -DifferenceObject $Items[1] -ExcludeDifferent | Select-Object -ExpandProperty InputObject -Unique | ForEach-Object {
        $Pt1Score += ConvertTo-Priority $_
    }
}

Write-Output "Pt1: $($Pt1Score)"


# pt2
$Pt2Items = @()
$a = @()
for ($i = 0; $i -lt $Data.Count; $i = $i + 3) {
    $Lines = $Data[$i..($i + 2)]
    $Lines[0] -split '' | Foreach-Object {
        if(($_ -cin $Lines[1].ToCharArray()) -and ($_ -cin $Lines[2].ToCharArray())) {$a += $_}
    }
    $Pt2Items += ($a | Select-Object -Unique) # remove repeated values with $a bodge
    $a = @()
}
$Pt2Score = 0
$Pt2Items | ForEach-Object {$Pt2Score += ConvertTo-Priority $_}

Write-Output "Pt2: $($Pt2Score)"
