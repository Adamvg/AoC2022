$Data = Get-Content .\input.txt

# pt1
$Scores = switch ($Data) {
    'A X' {4}
    'A Y' {8}
    'A Z' {3}
    'B X' {1}
    'B Y' {5}
    'B Z' {9}
    'C X' {7}
    'C Y' {2}
    'C Z' {6}
}
$Pt1Score = $Scores | Measure-Object -Sum | Select-Object -ExpandProperty Sum
Write-Output "Pt1: $($Pt1Score)"

# pt2
$Scores = switch ($Data) {
    'A X' {3}
    'A Y' {4}
    'A Z' {8}
    'B X' {1}
    'B Y' {5}
    'B Z' {9}
    'C X' {2}
    'C Y' {6}
    'C Z' {7}
}
$Pt2Score = $Scores | Measure-Object -Sum | Select-Object -ExpandProperty Sum
Write-Output "Pt2: $($Pt2Score)"

