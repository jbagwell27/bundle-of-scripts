# Author: Joshua Bagwell
# Version: 1.0
# Purpose: Set the max visible variable in the settings file to 18. (the amount of a single Full Mouth Series) so the system doesn't have to render all images

$filePath = "C:\DEXIS\Dexis.ini"
if ((Get-Content -Path $filePath -Raw) -contains 'maxvisible.*') {
    ((Get-Content -Path $filePath -Raw) -replace 'maxvisible.*', 'maxvisible=18') | Set-Content -Path $filePath
}
else {
    ForEach-Object {
        $_
        if ($_ -match "[SOFTWARE]") {

            "maxvisible=18"
        }
    } | Set-Content $filePath
}