
# Author: Joshua Bagwell
# Version: 1.0
# Purpose: To remove the first name from all patient records

$infFiles = Get-ChildItem . *.inf -rec
    foreach ($file in $infFiles) {
        Write-Host $file
        (Get-Content $file.PSPath) |
        Foreach-Object { $_ -replace "FN=.*", "" } |
        Set-Content $file.PSPath
    }