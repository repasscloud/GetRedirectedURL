Write-Verbose "Importing Module: GetRedirectedURL"
Import-Module -Name GetRedirectedURL

Write-Verbose "Installing Firefox to test against"
choco install firefox -y

Write-Verbose "Testing PS Module"
Get-UninstallString -Application firefox
if ($null -ne (Get-UninstallString -Application firefox)) {
    [System.Console]::ForegroundColor="Green";
    [System.Console]::WriteLine('Success!');
    [System.Console]::ResetColor();

    [System.Console]::ForegroundColor="Yellow";
    [System.Console]::Write('Build Number: ');
    [System.Console]::ResetColor();
    [System.Console]::WriteLine($Env:APPVEYOR_BUILD_NUMBER)

    [System.Console]::ForegroundColor="Yellow";
    [System.Console]::Write('Build ID: ');
    [System.Console]::ResetColor();
    [System.Console]::WriteLine($Env:APPVEYOR_BUILD_ID)

    [System.Console]::ForegroundColor="Yellow";
    [System.Console]::Write('Build Version: ');
    [System.Console]::ResetColor();
    [System.Console]::WriteLine($Env:APPVEYOR_BUILD_VERSION)

    [System.Console]::ForegroundColor="Yellow";
    [System.Console]::Write('Repo Commit: ');
    [System.Console]::ResetColor();
    [System.Console]::WriteLine($Env:APPVEYOR_REPO_COMMIT)

    [System.Console]::ForegroundColor="Yellow";
    [System.Console]::Write('Repo Branch: ');
    [System.Console]::ResetColor();
    [System.Console]::WriteLine($Env:APPVEYOR_REPO_BRANCH)

    [System.Console]::ForegroundColor="Yellow";
    [System.Console]::Write('Job Number: ');
    [System.Console]::ResetColor();
    [System.Console]::WriteLine($Env:APPVEYOR_JOB_NUMBER)
} else {
    [System.Console]::ForegroundColor="Red";
    [System.Console]::ResetColor();
    [System.Console]::WriteLine("Fail! :(")
    Stop-Computer -ComputerName $Env:COMPUTERNAME -Confirm:$false -Force
}

[System.Console]::WriteLine("Unloading Module: GetRedirectedURL")
Remove-Module -Name GetRedirectedURL -Force -Confirm:$false
