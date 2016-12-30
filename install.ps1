$client = new-object System.Net.WebClient
$client.DownloadFile("https://jenkins.pmmp.io/job/PocketMine-MP%20Dev/lastSuccessfulBuild/artifact/*zip*/PocketMine-MP.zip","C:\PMMP\PocketMine-MP.zip")
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

Unzip "C:\PMMP\PocketMine-MP.zip" "C:\PMMP"
Get-Childitem "C:\PMMP\archive" -recurse -filter "*.phar" | Copy-Item -Destination "C:\PMMP"
Remove-Item C:\PMMP\archive -recurse
Remove-Item C:\PMMP\PocketMine-MP.zip
# Rename-Item -LiteralPath "C:\PMMP\PocketMine-MP*.phar" -NewName "PocketMine-MP.phar"
$dir = "C:\PMMP"
$file = "PocketMine-MP*.phar"
get-childitem -Path $dir | where-object { $_.Name -like $file } | %{ rename-item -LiteralPath $_.FullName -NewName "PocketMine-MP.phar" }