#
# This script will increment the build number in an AssemblyInfo.cs and .nuspec file
#

function Update-AssemblyVersion([string] $assemblyInfoPath)
{
    $contents = [System.IO.File]::ReadAllText($assemblyInfoPath)

    $versionString = [RegEx]::Match($contents,"(AssemblyFileVersion\("")(\d+\.\d+\.\d+\.\d+)(""\))")
    Write-Host ("AssemblyFileVersion: " + $versionString.Groups[2])

    #Parse out the current build number from the AssemblyFileVersion
    $currentBuild = [RegEx]::Match($versionString,"(\.)(\d+)(\.)(\d+)(""\))").Groups[2]
    Write-Host ("Current Build: " + $currentBuild)

    #Increment the build number
    $newBuild= [int]$currentBuild.Value +  1
    Write-Host ("New Build: " + $newBuild)

    #update AssemblyFileVersion and AssemblyVersion, then write to file
    Write-Host ("Setting version in assembly info file ")
    $contents = [RegEx]::Replace($contents, "(AssemblyVersion\(""\d+\.\d+\.)(?:\d+)(\.\d+""\))", ("`${1}" + $newBuild.ToString() + "`${2}"))
    $contents = [RegEx]::Replace($contents, "(AssemblyFileVersion\(""\d+\.\d+\.)(?:\d+)(\.\d+""\))", ("`${1}" + $newBuild.ToString() + "`${2}"))
    Write-Host ("Contents: " + $contents)
    [System.IO.File]::WriteAllText($assemblyInfoPath, $contents)
}

function Update-Nuspec([string] $path)
{
    $contents = [System.IO.File]::ReadAllText($path)
    
    $versionString = [RegEx]::Match($contents,"(<version>)(\d+\.\d+\.\d+)(<\/version>)")
    Write-Host ("AssemblyFileVersion: " + $versionString.Groups[2])

    #Parse out the current build number from the AssemblyFileVersion
    $currentBuild = [RegEx]::Match($versionString,"(\.)(\d+)(<\/version>)").Groups[2]
    Write-Host ("Current Build: " + $currentBuild)

    #Increment the build number
    $newBuild= [int]$currentBuild.Value +  1
    Write-Host ("New Build: " + $newBuild)

    #update AssemblyFileVersion and AssemblyVersion, then write to file
    Write-Host ("Setting version in assembly info file ")
    $contents = [RegEx]::Replace($contents, "(<version>\d+\.\d+\.)(?:\d+)(<\/version>)", ("`${1}" + $newBuild.ToString() + "`${2}"))
    Write-Host ("Contents: " + $contents)
    [System.IO.File]::WriteAllText($path, $contents)
}

#Assumes that script is residing in the root folder of the project
$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
 
#Replace with the path to your assembly info
$assemblyInfoPath = $ScriptDir + "\project\Properties\AssemblyInfo.cs"
Write-Host "Backend AssemblyInfo Path: $backendAssemblyInfoPath"

#Replace with the path to nuspec file
$nuspecPath = $ScriptDir + "\package.nuspec"
Write-Host "Nuspec Path: $nuspecPath"

Update-AssemblyVersion $assemblyInfoPath
Update-Nuspec $nuspecPath