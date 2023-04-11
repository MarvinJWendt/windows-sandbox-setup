# This files generates the sandbox configs

$global:readmeContent = @"

| Name | Protected Client | vGPU | Memory | Networking | Clipboard Redirection | Printer Redirection | Video Input | Audio Input |
| ---- | ---------------- | ---- | ------ | ---------- | --------------------- | ------------------- | ----------- | ----------- |

"@

function Write-XMLConfiguration {
    param (
        [string]$FilePath,
        [string]$ProtectedClient = 'Disable',
        [string]$VGpu = 'Disable',
        [int]$MemoryInMB = 4000,
        [string]$Networking = 'Enable',
        [string]$ClipboardRedirection = 'Enable',
        [string]$PrinterRedirection = 'Disable',
        [string]$VideoInput = 'Disable',
        [string]$AudioInput = 'Enable'
    )

    $xmlContent = @"
<Configuration>
  <ProtectedClient>$ProtectedClient</ProtectedClient>
  <VGpu>$VGpu</VGpu>
  <MemoryInMB>$MemoryInMB</MemoryInMB>
  <Networking>$Networking</Networking>
  <ClipboardRedirection>$ClipboardRedirection</ClipboardRedirection>
  <PrinterRedirection>$PrinterRedirection</PrinterRedirection>
  <VideoInput>$VideoInput</VideoInput>
  <AudioInput>$AudioInput</AudioInput>
  <MappedFolders>
    <MappedFolder>
      <HostFolder>..\share\transfer</HostFolder>
      <SandboxFolder>C:\Users\WDAGUtilityAccount\Desktop\share\transfer</SandboxFolder>
      <ReadOnly>false</ReadOnly>
    </MappedFolder>
    <MappedFolder>
      <HostFolder>..\share\readonly</HostFolder>
      <SandboxFolder>C:\Users\WDAGUtilityAccount\Desktop\share\readonly</SandboxFolder>
      <ReadOnly>true</ReadOnly>
    </MappedFolder>
  </MappedFolders>
  <LogonCommand>
    <Command>C:\Users\WDAGUtilityAccount\Desktop\share\readonly\scripts\setup.cmd</Command>
  </LogonCommand>
</Configuration>
"@

    Set-Content -Path $FilePath -Value $xmlContent

    # append config to readme as a table
    $configName = $FilePath -replace '.wsb$'
    $configName = $configName -replace '.\\'
    $configName = $configName -replace '-', ' '
    $configName = $configName -replace 'vgpu', 'vGPU'

    # Append to readme table, replace "Enable" with "✔️" and "Disable" with "❌"
    $global:readmeContent += "| $configName | $($ProtectedClient -replace 'Enable', '✔️' -replace 'Disable', '❌') | $($VGpu -replace 'Enable', '✔️' -replace 'Disable', '❌') | $MemoryInMB | $($Networking -replace 'Enable', '✔️' -replace 'Disable', '❌') | $($ClipboardRedirection -replace 'Enable', '✔️' -replace 'Disable', '❌') | $($PrinterRedirection -replace 'Enable', '✔️' -replace 'Disable', '❌') | $($VideoInput -replace 'Enable', '✔️' -replace 'Disable', '❌') | $($AudioInput -replace 'Enable', '✔️' -replace 'Disable', '❌') |`n"

    Write-Output "Generated $FilePath"

}

# Write default
Write-XMLConfiguration -FilePath .\default.wsb
# Write default-with-vgpu
Write-XMLConfiguration -FilePath .\default-with-vgpu.wsb -VGpu 'Enable'

# Write performance
Write-XMLConfiguration -FilePath .\performance.wsb -MemoryInMB 8000
# Write performance-with-vgpu
Write-XMLConfiguration -FilePath .\performance-with-vgpu.wsb -MemoryInMB 8000 -VGpu 'Enable'

# Write secure
Write-XMLConfiguration -FilePath .\secure.wsb -ProtectedClient 'Enable' -ClipboardRedirection 'Disable' -PrinterRedirection 'Disable' -VideoInput 'Disable' -AudioInput 'Disable' -Networking 'Disable'
# Write secure-with-networking
Write-XMLConfiguration -FilePath .\secure-with-networking.wsb -ProtectedClient 'Enable' -ClipboardRedirection 'Disable' -PrinterRedirection 'Disable' -VideoInput 'Disable' -AudioInput 'Disable' -Networking 'Enable'

# Write unsecure
Write-XMLConfiguration -FilePath .\unsecure.wsb -ProtectedClient 'Disable' -ClipboardRedirection 'Enable' -PrinterRedirection 'Enable' -VideoInput 'Enable' -AudioInput 'Enable' -Networking 'Enable'
# Write unsecure-performance
Write-XMLConfiguration -FilePath .\unsecure-performance.wsb -ProtectedClient 'Disable' -ClipboardRedirection 'Enable' -PrinterRedirection 'Enable' -VideoInput 'Enable' -AudioInput 'Enable' -Networking 'Enable' -MemoryInMB 8000
# write unsecure-performance-vgpu
Write-XMLConfiguration -FilePath .\unsecure-performance-vgpu.wsb -ProtectedClient 'Disable' -ClipboardRedirection 'Enable' -PrinterRedirection 'Enable' -VideoInput 'Enable' -AudioInput 'Enable' -Networking 'Enable' -MemoryInMB 8000 -VGpu 'Enable'


# Write readme
Set-Content -Path .\README.md -Value $readmeContent

# Write table to "..\README.md" between the lines "<!-- configs:start -->" and "<!-- configs:end -->"

$readmePath = "..\README.md"

# Read the content of the README file
$readmeContent = Get-Content -Path $readmePath -Raw

# Define start and end tags for the configuration content
$startTag = "<!-- configs:start -->"
$endTag = "<!-- configs:end -->"

# Find start and end tag positions
$startTagIndex = $readmeContent.IndexOf($startTag) + $startTag.Length
$endTagIndex = $readmeContent.IndexOf($endTag)

# Replace content between start and end tags
$newReadmeContent = $readmeContent.Substring(0, $startTagIndex) + "`n" + $global:readmeContent + "`n" + $readmeContent.Substring($endTagIndex)

# Write the updated content back to the README file
Set-Content -Path $readmePath -Value $newReadmeContent
