@echo off
echo Currently installing latest PocketMine phar available from Jenkins...
set install=%1
Powershell.exe -executionpolicy remotesigned -command "%install%\install.ps1 %install%"
pause