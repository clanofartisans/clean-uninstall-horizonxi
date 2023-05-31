$config = $env:APPDATA + "\HorizonXI-Launcher\storage.json"

Write-Output "Uninstalling from Windows..."
Uninstall-Package -Name "HorizonXI-Launcher" -ErrorAction 'Ignore'

$config = Get-Content $config -Raw -ErrorAction 'Ignore'

$config = $config | ConvertFrom-Json

$path = $config.paths.installPath.path

$path -match "(?<installpath>\w:\\.+\\)Game" | out-null

$path = $Matches.installpath

if ($path) {
    Write-Output "Cleaning up game directory..."
    Remove-Item -path $path -recurse -force -ErrorAction 'Ignore'

    $path = $env:APPDATA + "\HorizonXI-Launcher"

    Write-Output "Cleaning up launcher directory..."
    Remove-Item -path $path -recurse -force -ErrorAction 'Ignore'

    $path = $env:LOCALAPPDATA + "\HorizonXI_Launcher"

    Write-Output "Cleaning up launcher configuration..."
    Remove-Item -path $path -recurse -force -ErrorAction 'Ignore'
}

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
