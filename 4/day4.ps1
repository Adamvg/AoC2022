$Data = Get-Content .\input.txt

$Subsets = 0
$OverLaps = 0

Foreach ($Line in $Data) {

    $Values = $Line -split '-' -split ','

    # create hashsets - yes i had to google this
    $Hs1 = [Collections.Generic.HashSet[int]]::new([int[]]($Values[0]..$Values[1]))
    $Hs2 = [Collections.Generic.HashSet[int]]::new([int[]]($Values[2]..$Values[3]))

    # pt1
    if ($Hs1.IsSubsetOf($Hs2) -or $Hs2.IsSubsetOf($Hs1)) {
        $Subsets++
    }

    # pt2
    if ($Hs1.Overlaps($Hs2) -or $Hs2.Overlaps($Hs1)) {
        $Overlaps++
    }
}

Write-Output "Pt1: $($Subsets)"
Write-Output "Pt2: $($Overlaps)"
