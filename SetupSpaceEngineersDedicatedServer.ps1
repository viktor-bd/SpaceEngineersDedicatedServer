# Run PowerShell as Administrator
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs

# Install Chocolatey
[System.Net.ServicePointManager]::SecurityProtocol = 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
$env:Path += ";$($env:ALLUSERSPROFILE)\chocolatey\bin"

# Install software using Chocolatey
choco install steamcmd -y
choco install vcredist2013 -y
choco install vcredist2017 -y

# Install SE DS using steamCMD

$steamCmdPath = "C:\ProgramData\chocolatey\lib\steamcmd\tools\steamcmd.exe"
$installDir = "C:\SpaceEngineersDedicatedServer"

Start-Process -FilePath $steamCmdPath -ArgumentList "+login anonymous +force_install_dir `"$installDir`" +app_update 298740 +quit"

# Add firewall inbound traffic rule allow traffic port 27016

# New-NetFirewallRule -DisplayName "Allow Inbound Traffic on Port 27016" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 27016

# Add firewall rule to allow the specified executable

$executablePath = "C:\SpaceEngineersDedicatedServer\DedicatedServer64\SpaceEngineersDedicated.exe"
New-NetFirewallRule -DisplayName "Allow SpaceEngineersDedicated.exe" -Direction Inbound -Action Allow -Program $executablePath