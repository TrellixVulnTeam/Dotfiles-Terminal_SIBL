﻿$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$workingDir = Join-Path $toolsDir "extract"
$packageArgs = @{
  PackageName = $env:ChocolateyPackageName
  FileFullPath64 = Get-Item $toolsDir\*.zip
  Destination = $workingDir
}

ls $toolsDir | ? { $_.PSIsContainer } | Remove-Item -Force -Recurse
Get-ChocolateyUnzip @packageArgs
New-Item -ItemType File -Path "$(ls $workingDir -r win_helper.exe | select -Expand FullName).ignore"  # do not create shim for win_helper
