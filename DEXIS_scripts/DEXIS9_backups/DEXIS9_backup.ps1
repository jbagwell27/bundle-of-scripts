
# Author: Joshua Bagwell
# Version: 1.0b
# Purpose: To perform a full backup of DEXIS 9 data

$workdir = findstr xdata C:\dexis\dexis.ini
$from = $workdir.trimstart('xdata=')

write-host $from
$to = Read-Host -Prompt 'Where do you want the main backup to go'

Copy-Item $from\* -Destination $to -recurse -Force

Write-Host "Finished"
read-host
