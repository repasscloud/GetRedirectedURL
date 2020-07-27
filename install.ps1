param ($fullPath)
#$fullPath = 'C:\Program Files\WindowsPowerShell\Modules\GetRedirectedURL'
if (-not $fullPath) {
    $fullpath = $env:PSModulePath -split ":(?!\\)|;|," |
        Where-Object {$_ -notlike ([System.Environment]::GetFolderPath("UserProfile")+"*") -and $_ -notlike "$pshome*"} |
            Select-Object -First 1
            $fullPath = Join-Path $fullPath -ChildPath "GetRedirectedURL"
}
Push-location $PSScriptRoot
Robocopy . $fullPath /mir /XD .git .devbots .github CI Tests bin lib Private /XF .gitignore appveyor.yml build.ps1 deploy.ps1 install.ps1 test.ps1 CODE-OF-CONDUCT.md CONTRIBUTING.md
Pop-Location