$Data = Get-Content .\input.txt -Raw # need Raw lines

$Stacks, $Instructions = ($Data) -split "`r`n`r`n"

# tidy
$Instructions = $Instructions -split "`r`n"

# hardcode because parsing this is ??? - needs to be Global to be used within the function
$Global:Stacks = @(
    $null,
    ([System.Collections.Generic.Stack[string]]::new([string[]]("CQB"))),
    ([System.Collections.Generic.Stack[string]]::new([string[]]("ZWQR"))),
    ([System.Collections.Generic.Stack[string]]::new([string[]]("VLRMB"))),
    ([System.Collections.Generic.Stack[string]]::new([string[]]("WTVHZC"))),
    ([System.Collections.Generic.Stack[string]]::new([string[]]("GVNBHZD"))),
    ([System.Collections.Generic.Stack[string]]::new([string[]]("QVFJCPNH"))),
    ([System.Collections.Generic.Stack[string]]::new([string[]]("SZWRTGD"))),
    ([System.Collections.Generic.Stack[string]]::new([string[]]("PZWBNMGC"))),
    ([System.Collections.Generic.Stack[string]]::new([string[]]("PFQWMBJN")))
)

# moving function
# Part 1    
function Move-StackPt1 ($Count, $From, $To) {
   1..$Count | ForEach-Object {
       $Item = $Global:Stacks[$From].pop()
       $Global:Stacks[$To].Push($Item)
   }
}
# Part 2
# function Move-StackPt2 ($Count, $From, $To) {
#     [array]$TempArray = 1..$Count | ForEach-Object {
#         $Global:Stacks[$From].pop()
#     }
#     # reverse the array
#     [array]::Reverse($TempArray)
#     $TempArray | ForEach-Object {
#         $Global:Stacks[$To].Push($_)
#     }
# }

Foreach ($Instruction in $Instructions) {
    $SplitInstruction = $Instruction -split ' '
    Move-StackPt1 -Count $SplitInstruction[1] -From $SplitInstruction[3] -To $SplitInstruction[5]
    #Move-StackPt2 -Count $SplitInstruction[1] -From $SplitInstruction[3] -To $SplitInstruction[5]
}

$Output = @()
$Stacks | ForEach-Object {
    $Output += ($_ -join '')[0]
}
Write-Output $($Pt1Output -join '')