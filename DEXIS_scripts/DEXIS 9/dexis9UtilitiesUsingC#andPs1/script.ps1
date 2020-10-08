# Author: Joshua Bagwell
# Version: 3.0b
# Use case: Bulk change provider in DEXIS9

# The values need to be manually changed in the script
# A future revision will include a more user-friendly alternative

# 2.0 changes: Added a prompt for user input for the provider ID values. Added feature to move Files to force a rebuild

param( [INT32]$option = 0, [INT32]$provider1 = 0, [INT32]$provider2 = 0, [String]$id )

function set_data_path {
    if ([System.Environment]::Is64BitOperatingSystem) {
        $key = "HKLM:\SOFTWARE\WOW6432Node\DEXIS\DEXIS"
        $filePath = (Get-ItemProperty -Path $key -Name Directory).Directory + "\dexis.ini"

        $dataPath = [String]( Get-Content -Path $filePath | Select-String -Pattern "xdata")
        $result = $dataPath.Trim("xdata=")

        Set-Location $result

    }
    else {
        $key = "HKLM:\SOFTWARE\DEXIS\DEXIS"
        $filePath = (Get-ItemProperty -Path $key -Name Directory).Directory + "\dexis.ini"

        $dataPath = [String]( Get-Content -Path $filePath | Select-String -Pattern "xdata")
        $result = $dataPath.Trim("xdata=")

        Set-Location $result
    }
}

function change_provider() {
    set_data_path
    
    $infFiles = Get-ChildItem . *.inf -rec
    foreach ($file in $infFiles) {
        (Get-Content $file.PSPath) |
        Foreach-Object { $_ -replace "DT=$provider1", "DT=$provider2" } |
        Set-Content $file.PSPath
    }
}

function clear_birthday {  
    set_data_path
    
    $infFiles = Get-ChildItem . *.inf -rec
    foreach ($file in $infFiles) {
        (Get-Content $file.PSPath) |
        Foreach-Object { $_ -replace "BD=.*", "" } |
        Set-Content $file.PSPath
    }
    
}

function del_lck {    
    set_data_path

    Get-ChildItem *.lck -Recurse | ForEach-Object { Remove-Item -Path $_.FullName }
    
}
    
function sel_pat {
    set_data_path

    while ($id.Length -lt 5) {
        $id = '0' + $id
    }
    $text = (& { for ($i = 0; $i -lt $id.Length; $i++) {
                $id.Substring($i, 1)
            } }) -join '\'
        
    Invoke-Item $text
}
    
function force_rebuild {
    set_data_path

    New-Item -Name 'Trash' -ItemType directory
    Move-Item -Path xpat.dat -Destination Trash\xpat.dat -force
    Move-Item -Path xpatid.dat -Destination Trash\xpatid.dat -force
    Move-Item -Path DEXIS.CHK -Destination Trash\DEXIS.CHK -force
}

switch ($option) {
    1 { change_provider }
    2 { clear_birthday }
    3 { del_lck }
    4 { sel_pat }
    5 { force_rebuild }
    Default { }
}