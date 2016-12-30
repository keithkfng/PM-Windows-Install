$install_path=$args[0]
$client = new-object System.Net.WebClient
$client.DownloadFile("https://jenkins.pmmp.io/job/PocketMine-MP%20Dev/lastSuccessfulBuild/artifact/*zip*/PocketMine-MP.zip","$install_path\PocketMine-MP.zip")
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

Unzip "$install_path\PocketMine-MP.zip" "$install_path"
Get-Childitem "$install_path\archive" -recurse -filter "*.phar" | Copy-Item -Destination "$install_path"
Remove-Item $install_path\archive -recurse
Remove-Item $install_path\PocketMine-MP.zip
# Rename-Item -LiteralPath "C:\PMMP\PocketMine-MP*.phar" -NewName "PocketMine-MP.phar"
$dir = $install_path
$file = "PocketMine-MP*.phar"
get-childitem -Path $dir | where-object { $_.Name -like $file } | %{ rename-item -LiteralPath $_.FullName -NewName "PocketMine-MP.phar" }