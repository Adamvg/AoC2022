# heavy inspiration and regex from https://www.reddit.com/r/PowerShell/comments/zeux8r/comment/izagzzh/?utm_source=share&utm_medium=web2x&context=3
$Data = Get-Content .\input.txt

$ErrorActionPreference = 'Stop' # stop at first error

[Collections.Stack]$PathStack = @()
$TreeSize = @{}

$Data | Select-Object {$_}, @{n='p';e={
  switch -regex($_){
    '^(\d+) .*' { $PathStack|%{ $TreeSize[$_] += +$matches[1] } } # add size to all paths in stack
    '^\$ cd /' { $global:PathStack = @('') }                # reset the path stack
    '^\$ cd \.\.$' { [void]$PathStack.Pop() }               # go up one level
    '^\$ cd (?!(/|\.\.)$)(?<d>.+)$' {               # match CDs that aren't to / or ..
      $PathStack.Push($PathStack.Peek() + '/' + $Matches['d'])      # treat CD as PUSHD, sort of
    }
  }
  @([Collections.Stack]@($p)).ForEach({"[$_]"})} # debugging
  }

$Pt1 = $TreeSize.Values -le 100000 | Measure-Object -Sum | Select-Object -ExpandProperty Sum   # part 1
$Pt2 = $TreeSize.Values -ge ($TreeSize[''] - 40000000) | Sort-Object -Top 1  # part 2

Write-Output "Pt1: $($Pt1)"
Write-Output "Pt2: $($Pt2)"
