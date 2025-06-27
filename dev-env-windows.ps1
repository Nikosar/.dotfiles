param(
    [switch]$dry,
    [string]$filter=""
)

$script_dir = (Get-Location).Path

function Log {
    param([string]$message)
    if ($dry) {
        Write-Output "[DRY_RUN]: $message"
    } else {
        Write-Output $message
    }
}

function Execute {
    param([string]$command)
    Log "execute $command"
    if ($dry) {
        return
    }
    Invoke-Expression $command
}

Log "-------------------- dev --------------------"
Write-Output "scripts dir $script_dir"

function Copy-Dir {
    param(
        [string]$sourceDir,
        [string]$targetDir
    )
    $sourcePath = Join-Path -Path $script_dir -ChildPath "env/$sourceDir"
    $dirs = Get-ChildItem -Directory -Path $sourcePath
    foreach ($dir in $dirs) {
        $targetPath = Join-Path -Path $targetDir -ChildPath $dir.Name
        if (-not ($targetPath.toString() -Match $filter)) {
            Continue
        }
        Execute "Remove-Item -Recurse -Force $targetPath"
        Execute "Copy-Item -Recurse $($dir.FullName) $targetPath"
    }
}

function Copy-File {
    param(
        [string]$sourceFile,
        [string]$targetDir
    )
    $sourcePath = Join-Path -Path $script_dir -ChildPath "env/$sourceFile"
    $fileName = [System.IO.Path]::GetFileName($sourcePath)
    $targetPath = Join-Path -Path $targetDir -ChildPath $fileName

    if (-not ($targetPath.toString() -Match $filter)) {
        Return
    }
    Execute "Remove-Item $targetPath"
    Execute "Copy-Item $sourcePath $targetPath"
}

Copy-Dir ".config" "$HOME\.config"
Copy-Dir ".local" "$HOME\.local"
New-Item -ItemType Directory -Path "$HOME\Documents\PowerShell"
Copy-File "Microsoft.PowerShell_profile.ps1" "$HOME\Documents\PowerShell"

Log "-------------------- dev --------------------"

