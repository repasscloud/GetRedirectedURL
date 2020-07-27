#Find.Uninstaller

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/947571116b1d49da90fe1a008dd33f35)](https://www.codacy.com/gh/repasscloud/Find.Uninstaller?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=repasscloud/Find.Uninstaller&amp;utm_campaign=Badge_Grade) [![Build status](https://ci.appveyor.com/api/projects/status/kgr9nq2f82c2r5ys/branch/master?svg=true)](https://ci.appveyor.com/project/danijeljw/find-uninstaller/branch/master)

Quickly find the uninstall string of an application without leaving the terminal or using lengthy commands.

## Installation

```powershell
Install-Module Find.Uninstaller
```

## Commands

| Name | Synopsis |
| :-- | :-- |
| `Get-UninstallString -Application <appName>` | Retrieves an uninstall for \<appName\> |
| `Get-UninstallString -Application <appName> -FullDetail $true` | Retrieves all infomrmation for \<appName\> |
