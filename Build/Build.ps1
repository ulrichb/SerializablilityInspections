[CmdletBinding()]
Param(
  [Parameter()] [string] $NugetExecutable = "Shared\.nuget\nuget.exe",
  [Parameter()] [string] $Configuration = "Debug",
  [Parameter()] [string] $Version = "0.0.0.1",
  [Parameter()] [string] $BranchName,
  [Parameter()] [string] $CoverageBadgeUploadToken,
  [Parameter()] [string] $NugetPushKey
)

Set-StrictMode -Version 2.0; $ErrorActionPreference = "Stop"; $ConfirmPreference = "None"

. Shared\Build\BuildFunctions

$BuildOutputPath = "Build\Output"
$SolutionFilePath = "SerializationInspections.sln"
$MSBuildPath = (Get-ChildItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\*\MSBuild\15.0\Bin\MSBuild.exe").FullName
$NUnitAdditionalArgs = "--x86 --labels=All --agents=1"
$NUnitTestAssemblyPaths = @(
    "Src\SerializationInspections.Plugin.Tests\bin\$Configuration\SerializationInspections.Plugin.Tests.dll"
    "Src\SerializationInspections.Plugin.Tests\test\data\bin\$Configuration\SerializationInspections.Sample.dll"
)
$NUnitFrameworkVersion = "net-4.5"
$TestCoverageFilter = "+[SerializationInspections*]* -[SerializationInspections*]ReSharperExtensionsShared.* -[SerializationInspections.Sample]*"
$NuspecPath = "Src\SerializationInspections.nuspec"
$NugetPackProperties = @(
    "Version=$(CalcNuGetPackageVersion 20171);Configuration=$Configuration;DependencyVer=[8.0];BinDirInclude=bin"
)
$NugetPushServer = "https://www.myget.org/F/ulrichb/api/v2/package"

Clean
PackageRestore
Build
NugetPack
Test

if ($NugetPushKey) {
    NugetPush
}
