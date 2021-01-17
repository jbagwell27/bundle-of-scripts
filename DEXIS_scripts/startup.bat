@echo off

rem Wiki
start /max http://denorasvwiki/dokuwiki/doku.php?id=start&do=login
timeout 1

rem IOT Dashboard
start /max https://dwtblprod.kavokerrgroup.com/#/views/IoTTechicalSupport/
timeout 1

rem IOT Form
start /max https://forms.office.com/Pages/ResponsePage.aspx?id=mDt7ExXzJUCuJz0X6b8NZrMPhDY2o7FAhOeoJlhc2j1UM1hIT0lINlRVUEE1MzExVkZFRlhLUTEwMi4u
timeout 1

rem L1 Board
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe"  --profile-directory=Default --app-id=eeecglnhhehdkbiioeldbedmjfghobea
rem "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe"  --profile-directory=Default --app-id=dgbhiheoloepifpoedpipnihdcbnfibf
timeout 1

rem Old CRM
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe"  --profile-directory=Default --app-id=gimmgbecmngcelokklpgcdfmmjbmcodn
timeout 1

rem Dynamics Web App
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe"  --profile-directory=Default --app-id=pggdkmbinoiommokgkaeccmeckaibnll
timeout 1

rem Cisco Finesse
rem start msedge --new-window https://denlassvuccx2.sds.sybrondental.com:8445/desktop/container/landing.jsp?locale=en_US
start iexplore.exe https://denlassvuccx2.sds.sybrondental.com:8445/desktop/container/landing.jsp?locale=en_US
rem start iexplore.exe https://denalpsvuccx1.sds.sybrondental.com:8445/desktop/container/?locale=en_US
timeout 1

rem start msedge --new-window http://denorasvwiki/dokuwiki/doku.php?id=start&do=login
rem start msedge --new-window https://dental.crm.dynamics.com/
rem start /max http://denalpsvwb02/dashboard/iot/ts
rem start /max https://envistaconnect.sharepoint.com/sites/kavokerr/teams/Operations/alpharetta/techsupport/Level1/SitePages/Home.aspx

start CiscoJabber.lnk
timeout 1

start outlook.lnk
timeout 1

start MicrosoftTeams.lnk
timeout 1

rem start Note_Generator_v1.lnk
rem timeout 1

start PortableAppsStart.lnk
timeout 1

net use p: \\denalpsvfs\public
net use s: \\denalpsvfs\data
net use z: \\denhtlsvfs\data
