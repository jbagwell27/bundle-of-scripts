
# Author: Joshua Bagwell
# Version: 3.0b
# Purpose: A list of utilities to perform simple tasks such as Changing the provider, delete any lck files that are preventing patient records from opening, opening a patient record in the file explorer, and rebuilding the patient index

# The values need to be manually changed in the script
# A future revision will include a more user-friendly alternative

# 2.0 changes: Added a prompt for user input for the provider ID values Added feature to move Files to force a rebuild

param([Int32]$option = 0)
            
function change_provider() {
    New-Item -Name 'Trash' -ItemType directory
    Move-Item -Path xpat.dat -Destination Trash\xpat.dat -force
    Move-Item -Path xpatid.dat -Destination Trash\xpatid.dat -force
    Move-Item -Path DEXIS.CHK -Destination Trash\DEXIS.CHK -force
    
    Clear-Host
    
    $firstProvider = Read-Host -Prompt 'Please enter old provider number: '
    $secondProvider = Read-Host -Prompt 'Please enter new provider number: '
    $infFiles = Get-ChildItem . *.inf -rec
    foreach ($file in $infFiles) {
        (Get-Content $file.PSPath) |
        Foreach-Object { $_ -replace "DT=$firstProvider", "DT=$secondProvider" } |
        Set-Content $file.PSPath
    }
}

function clear_birthday {  
    New-Item -Name 'Trash' -ItemType directory
    Move-Item -Path xpat.dat -Destination Trash\xpat.dat -force
    Move-Item -Path xpatid.dat -Destination Trash\xpatid.dat -force
    Move-Item -Path DEXIS.CHK -Destination Trash\DEXIS.CHK -force
    
    Clear-Host

    $infFiles = Get-ChildItem . *.inf -rec
    foreach ($file in $infFiles) {
        Write-Host $file
        (Get-Content $file.PSPath) |
        Foreach-Object { $_ -replace "BD=.*", "" } |
        Set-Content $file.PSPath
    }

}

function del_lck {
    Clear-Host

    Get-ChildItem *.lck -Recurse | ForEach-Object { Remove-Item -Path $_.FullName }  
}

function sel_pat {
    Clear-Host

    $id = Read-Host -Prompt 'What is the ID'
    while ($id.Length -lt 5) {
        $id = '0' + $id
    }
    $text = (& { for ($i = 0; $i -lt $id.Length; $i++) {
                $id.Substring($i, 1)
            } }) -join '\'

    Invoke-Item $text
}

function rebuild_index {
    Clear-Host

    New-Item -Name 'Trash' -ItemType directory
    Move-Item -Path xpat.dat -Destination Trash\xpat.dat -force
    Move-Item -Path xpatid.dat -Destination Trash\xpatid.dat -force
    Move-Item -Path DEXIS.CHK -Destination Trash\DEXIS.CHK -force
}

Clear-Host

if ($option -eq 0) {
    $option = Read-Host -Prompt 'Which function do you want to run:
    1:  Change Provider
    2:  Clear Birthday
    3:  Delete LCK Files
    4:  Navigate to patient record
    '
    switch ($option) {
        1 { change_provider }
        2 { clear_birthday }
        3 { del_lck }
        4 { sel_pat }
        5 { rebuild_index }
        Default { }
    }
}
else {
    switch ($option) {
        1 { change_provider }
        2 { clear_birthday }
        3 { del_lck }
        4 { sel_pat }
        5 { rebuild_index }
        Default { }
    }
    
}