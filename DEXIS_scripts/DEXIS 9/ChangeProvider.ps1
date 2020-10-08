
# Author: Joshua Bagwell
# Version: 2.0b
# Purpose: Bulk change provider in DEXIS9

# The values need to be manually changed in the script
# A future revision will include a more user-friendly alternative

# 2.0 changes: Added a prompt for user input for the provider ID values Added feature to move Files to force a rebuild

New-Item -Name 'Trash' -ItemType directory
Move-Item -Path xpat.dat -Destination Trash\xpat.dat -force
Move-Item -Path xpatid.dat -Destination Trash\xpatid.dat -force
Move-Item -Path DEXIS.CHK -Destination Trash\DEXIS.CHK -force


$firstProvider = Read-Host -Prompt 'Please enter old provider number: '
$secondProvider = Read-Host -Prompt 'Please enter new provider number: '
$infFiles = Get-ChildItem . *.inf -rec
foreach ($file in $infFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -replace "DT=$firstProvider", "DT=$secondProvider" } |
    Set-Content $file.PSPath
}