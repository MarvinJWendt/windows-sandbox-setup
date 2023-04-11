# ┌─────────────────────────────────────────────────────────┐
# │                                                         │
# │  https://github.com/MarvinJWendt/windows-sandbox-setup  │
# │                                                         │
# └─────────────────────────────────────────────────────────┘

# This script is executed on every sandbox startup

# Set execution policy to unrestricted
Start-Process PowerShell -ArgumentList "Set-ExecutionPolicy unrestricted -Force" -Verb RunAs

# Disable Windows Smartscreen
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Type DWord -Value 0
If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 0

Import-Module Appx -UseWindowsPowerShell

# Install all *.msixbundle and *.appx files in the assets folder
Get-ChildItem -Recurse C:\Users\WDAGUtilityAccount\Desktop\share\readonly\scripts\assets\ -Include *.appx, *.msixbundle | ForEach-Object { Add-AppxPackage $_.FullName }

# Create a prompt message that the setup is done
$setupDone = New-Object -ComObject WScript.Shell
$setupDone.Popup("Automatic Sandbox setup is done!", 0, "Setup", 0x40)