$url = "https://electrolynx.dev/uselinux.png"

Start-Process $url

Start-Sleep -Seconds 5
$wshell = New-Object -ComObject wscript.shell
$wshell.SendKeys("{F11}")
