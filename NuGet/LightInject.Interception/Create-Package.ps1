$scriptpath = split-path -parent $MyInvocation.MyCommand.Path
$assemblyPath = resolve-path "$scriptpath/../LightInject.PreProcessor.dll"
$sourcepath = resolve-path "$scriptpath../../../LightInject.Interception/LightInjectInterception.cs"
write "Loading assembly"
[Reflection.Assembly]::LoadFile($assemblyPath)
write "Processing $sourcepath"

$targetPath = $scriptpath + "\package\content\net40\"
new-item  $targetPath -itemtype directory -ErrorAction SilentlyContinue
[LightInject.PreProcessor.SourceWriter]::Write("NET",$sourcepath,"$targetPath\LightInjectInterception.cs.pp")

$targetPath = $scriptpath + "\package\content\net45\"
new-item  $targetPath -itemtype directory -ErrorAction SilentlyContinue
[LightInject.PreProcessor.SourceWriter]::Write("NET",$sourcepath,"$targetPath\LightInjectInterception.cs.pp")


pushd $scriptpath

.\..\Nuget.exe pack package/LightInject.Interception.nuspec -OutputDirectory "..\"

popd


