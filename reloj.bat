@echo off
powershell -NoProfile -Command ^
"while ($true) { ^
    Clear-Host; ^
        $hora = Get-Date -Format 'HH:mm:ss'; ^
            $anchura = $Host.UI.RawUI.WindowSize.Width; ^
                $espacios = (' ' + $hora).PadLeft([math]::Floor($anchura/2)+$hora.Length/2); ^
                    Write-Host $espacios -ForegroundColor Cyan; ^
                        Start-Sleep -Seconds 1 ^
                        }"
                        
echo RELOJ
