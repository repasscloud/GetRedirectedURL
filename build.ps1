$PSD1=$PSScriptRoot+'\GetRedirectedURL.psd1'
if (Test-Path -Path $PSD1) {
    Remove-Item -Path $PSD1 -Confirm:$false -Force
}

$Description = @"
Return the redirect (or final redirect) of any provided URL. Helpful when provided with shortlinks
or links that redirect a few times and you cannot use to access the file you want as they go through
a few redirects.

Example:
  Get-RedirectedURL -URL 'https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win64&lang=en-US'

  returns: "https://download-installer.cdn.mozilla.net/pub/firefox/releases/78.0.2/win64/en-US/Firefox%20Setup%2078.0.2.msi"
"@

$FileList=@(
    '.\public',
    '.\LICENSE',
    '.\README.md',
    '.\GetRedirectedURL.psm1',
    '.\CHANGELOG.md'
)

$Author='Danijel-James Wynyard'
$CompanyName='RePass Cloud Pty Ltd'
$Copyright='Copyright '+[char]0x00A9+' 2020 RePass Cloud Pty Ltd'

$Tags=@('http','https','redirect','url','uri','redirects','web')
$ProjectUri='https://github.com/repasscloud/GetRedirectedURL'
$LicenseUri='https://github.com/repasscloud/GetRedirectedURL/blob/master/LICENSE'
$ReleaseNotes=@"
- Initial powershell module release
"@

#Get public and private function definition files
$Public=Get-ChildItem $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue
#$Private = Get-ChildItem $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue 
#Create some aliases, export public functions
$FunctionsToExport=@( $($Public | Select-Object -ExpandProperty BaseName) )


$HelpInfoURI='https://raw.githubusercontent.com/repasscloud/GetRedirectedURL/master/README.md'

$ModuleVersion=$Env:APPVEYOR_BUILD_VERSION

New-ModuleManifest -Path $PSD1 `
  -Author $Author `
  -CompanyName $CompanyName `
  -Copyright $Copyright `
  -RootModule 'GetRedirectedURL.psm1' `
  -ModuleVersion $ModuleVersion `
  -Description $Description `
  -PowerShellVersion '5.1' `
  -ProcessorArchitecture None `
  -FileList $FileList `
  -Tags $Tags `
  -ProjectUri $ProjectUri `
  -LicenseUri $LicenseUri `
  -ReleaseNotes $ReleaseNotes `
  -FunctionsToExport $FunctionsToExport `
  -HelpInfoUri $HelpInfoURI

if ($Env:APPVEYOR_BUILD_NUMBER) {
    $CurrentBuild=$Env:APPVEYOR_BUILD_NUMBER
}

# Update the PS Scripts with the version and build
$OldVersionString='Version: 2.0.1.4';
$NewVersionString="Version: 2.0.1.{0}" -f $CurrentBuild
$LastUpdated='Last Updated:';
$LatestUpdated="Last Updated: $((Get-Date).ToString('yyyy-MM-dd'))";
Get-ChildItem -Path "$Env:APPVEYOR_BUILD_FOLDER\public" -Filter "*.ps1" | ForEach-Object {
    $ManifestContent = Get-Content -Path $_.FullName -Raw;
    $ManifestContent = $ManifestContent -replace $OldVersionString,$NewVersionString;
    $ManifestContent = $ManifestContent -replace $LastUpdated,$LatestUpdated;
    Set-Content -Path $_.FullName -Value $ManifestContent -Force;
}
