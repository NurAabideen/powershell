
Get-Date | Out-File C:\users\nur\Documents\log.txt -Append
hostname | Out-File C:\users\nur\Documents\log.txt -Append
Get-PSDrive -PSProvider FileSystem | Out-File C:\Users\nur\Documents\log.txt -Append