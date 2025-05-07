<#
.SYNOPSIS
    TicketGhost Installer for Windows (PowerShell)
.DESCRIPTION
    - Extracts ticketghost_full_bundle.zip to $HOME\scripts
    - Prompts for API key and updates ticketghost.sh
    - Offers to create a shortcut to run it
#>

$zipName = "ticketghost_full_bundle.zip"
$installDir = "$HOME\scripts"
$scriptPath = Join-Path $installDir "ticketghost.sh"

# Step 1: Ensure scripts directory
if (!(Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir | Out-Null
    Write-Host "📁 Created $installDir"
} else {
    Write-Host "📁 $installDir already exists"
}

# Step 2: Verify zip presence
if (!(Test-Path $zipName)) {
    Write-Host "❌ $zipName not found. Place it in the same folder as this installer." -ForegroundColor Red
    exit 1
}

# Step 3: Extract ZIP
if (Get-Command Expand-Archive -ErrorAction SilentlyContinue) {
    Expand-Archive -Path $zipName -DestinationPath $installDir -Force
    Write-Host "✅ Extracted to $installDir"
} else {
    Write-Host "⚠️ Expand-Archive not available. Attempting 7-Zip fallback..."
    $sevenZipPath = "$env:ProgramFiles\7-Zip\7z.exe"
    if (!(Test-Path $sevenZipPath)) {
        Write-Host "📦 Downloading and installing 7-Zip..."
        $installerUrl = "https://www.7-zip.org/a/7z2301-x64.exe"
        $installerPath = "$env:TEMP\\7zsetup.exe"
        Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
        Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait
    }
    if (Test-Path $sevenZipPath) {
        & "$sevenZipPath" x $zipName "-o$installDir" -y | Out-Null
        Write-Host "✅ Extracted with 7-Zip to $installDir"
    } else {
        Write-Host "❌ 7-Zip installation failed. Please extract manually." -ForegroundColor Red
        exit 1
    }
}

# Step 4: Prompt for API key
$apiKey = Read-Host "🔑 Enter your ServiceDesk API key"
(Get-Content $scriptPath) -replace 'API_KEY="your_api_key_here"', "API_KEY=`"$apiKey`"" | Set-Content $scriptPath
Write-Host "✅ API key injected into script"

# Step 5: Offer shortcut creation
$choice = Read-Host "📎 Create desktop shortcut to run it? (y/n)"
if ($choice -match "^[Yy]$") {
    $shortcutPath = "$HOME\Desktop\TicketGhost.lnk"
    $targetPath = "wsl.exe"
    $arguments = "-e bash $scriptPath"
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $targetPath
    $shortcut.Arguments = $arguments
    $shortcut.IconLocation = "$env:SystemRoot\System32\SHELL32.dll,12"
    $shortcut.Save()
    Write-Host "✅ Shortcut created on Desktop"
}

Write-Host "`n🎉 TicketGhost setup complete! Run it anytime with:"
Write-Host "   wsl bash $scriptPath" -ForegroundColor Cyan
