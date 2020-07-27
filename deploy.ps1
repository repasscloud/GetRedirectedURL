<#
	.Author
	Trevor Sullivan <trevor@trevorsullivan.net>
	.Description
	Publishes the PowerShell module to the PowerShell Gallery.
	This PowerShell script is invoked by AppVeyor after the "Deploy" phase has completed successfully.
#>

function Invoke-PatchModuleManifest {
	[CmdletBinding()]
	param (
		[string] $Path,
	    [string] $BuildNumber
	)

	if (-not($Path)) {
		$Path = Get-ChildItem -Path $Env:APPVEYOR_BUILD_FOLDER -Include *.psd1;
		if (-not($Path)) { throw 'Could not find a module manifest file'; }
	}

	$ManifestContent = Get-Content -Path $Path -Raw;
	$ManifestContent = $ManifestContent -replace '(?<=ModuleVersion\s+=\s+'')(?<ModuleVersion>.*)(?='')', ('${{ModuleVersion}}.{0}' -f $BuildNumber);
	Set-Content -Path $Path -Value $ManifestContent;

	$ManifestContent -match '(?<=ModuleVersion\s+=\s+'')(?<ModuleVersion>.*)(?='')';
	Write-Verbose -Message ('Module Version patched: ' + $Matches.ModuleVersion);
}

function Main {
	[CmdletBinding()]
	param ($fullPath)
	$VerbosePreference = 'Continue';

	### Skip the build if the Git tag does not match "release"
	#Write-Output -InputObject "Git tag is: $Env:APPVEYOR_REPO_TAG_NAME";
	#if ($Env:APPVEYOR_REPO_TAG_NAME -notmatch 'release') {
		#throw 'The release tag was not found on this commit. Skipping deployment.';
		#return;
	#	Write-Host $Env:APPVEYOR_REPO_TAG_NAME
	#}
	#else {
	#Write-Verbose -Message ('The release tag ({0}) was found on this commit. Starting deployment.' -f $Env:APPVEYOR_REPO_TAG_NAME);
	
	#$fullPath = 'C:\Program Files\WindowsPowerShell\Modules\Get.URLStatusCode'
	if (-not $fullPath) {
		$fullpath = $env:PSModulePath -split ":(?!\\)|;|," |
			Where-Object {$_ -notlike ([System.Environment]::GetFolderPath("UserProfile")+"*") -and $_ -notlike "$pshome*"} |
				Select-Object -First 1
				$fullPath = Join-Path $fullPath -ChildPath "GetRedirectedURL"
	}
		'AppVeyor Build Folder: {0}' -f $Env:APPVEYOR_BUILD_FOLDER;
		Write-Verbose -Message 'Calling Find-Package command to download nuget-anycpu.exe'
		Find-Package -ForceBootstrap -Name zzzzzz -ErrorAction Ignore;

		#Invoke-PatchModuleManifest -Path $Env:APPVEYOR_BUILD_FOLDER\GetRedirectedURL.psd1 -BuildNumber $Env:APPVEYOR_BUILD_NUMBER;

		Write-Verbose -Message ('Publishing module {0} to Gallery!' -f $Env:APPVEYOR_BUILD_FOLDER);
		Publish-Module -Path $fullPath -NuGetApiKey $Env:NUGET_API_KEY;
		Write-Verbose -Message 'Finished publishing module!'
	#}
}

### Invoke Main function
Main;