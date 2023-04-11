Write-Output "Windows Sandbox Setup Script"

Write-Output "# Downloading assets..."

Write-Output "## Downloading VCLibs..."
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile ./share/readonly/scripts/assets/1_Microsoft.VCLibs.appx

Write-Output "## Downloading Winget..."
Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v1.3.2691/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile ./share/readonly/scripts/assets/2_Microsoft.DesktopAppInstaller.msixbundle

Write-Output "## Downloading Microsoft UI Xaml..."
Invoke-WebRequest -Uri https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.3 -OutFile .\microsoft.ui.xaml.2.7.3.zip
Expand-Archive .\microsoft.ui.xaml.2.7.3.zip
# Remove older version of Microsoft.UI.Xaml
Remove-Item ./share/readonly/scripts/assets/3_Microsoft.UI.Xaml.2.7.appx
# Move .\microsoft.ui.xaml.2.7.3\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx to ./share/readonly/scripts/assets/3_Microsoft.UI.Xaml.2.7.appx
Move-Item .\microsoft.ui.xaml.2.7.3\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx ./share/readonly/scripts/assets/3_Microsoft.UI.Xaml.2.7.appx
# Remove .\microsoft.ui.xaml.2.7.3.zip and .\microsoft.ui.xaml.2.7.3
Remove-Item .\microsoft.ui.xaml.2.7.3.zip
Remove-Item .\microsoft.ui.xaml.2.7.3 -Recurse

Write-Output "## Downloading Windows Terminal..."
Invoke-WebRequest -Uri https://github.com/microsoft/terminal/releases/download/v1.16.10261.0/Microsoft.WindowsTerminal_Win11_1.16.10262.0_8wekyb3d8bbwe.msixbundle -OutFile ./share/readonly/scripts/assets/4_Microsoft.WindowsTerminal.msixbundle
