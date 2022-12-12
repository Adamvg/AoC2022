$Data = Get-Content .\input.txt
# pt1
for ($i = 0; $i -lt $Data.Length; $i++) {
    if(($Data[$i..($i + 3)] | Select-Object -Unique).count -eq 4){
        Write-Output "Pt1: $($i + 4)" # +4 to include the marker itself
        break
    }
}

#pt2
for ($i = 0; $i -lt $Data.Length; $i++) {
    if(($Data[$i..($i + 13)] | Select-Object -Unique).count -eq 14){
        Write-Output "Pt1: $($i + 14)" # +14 to include the marker itself
        break
    }
}

# jqvg