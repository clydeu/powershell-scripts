# Enable Hyper-V
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V

# Enable WSL
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# Install tools
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install firefox
choco install git.install
choco install sourcetree
choco install visualstudio2019community
choco install youtube-dl
choco install sqlitebrowser
choco install mkdocs
choco install slack
choco install putty
choco install nuget.commandline
choco install putty
choco install paint.net
choco install notepadpluplus.install
choco install notepadplusplus.install
choco install nugetpackageexplorer
choco install notepadplusplus-pluginmanager
choco install notepadplusplus-npppluginmanager
choco install dotpeek
choco install vscode
choco install docker-desktop
choco install wsl-ubuntu-1804
