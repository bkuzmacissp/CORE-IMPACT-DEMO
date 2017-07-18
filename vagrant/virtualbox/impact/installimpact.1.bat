mkdir c:\Temp
copy c:\vagrant\impact\CORE_IMPACT-2017_R2.exe c:\temp\CORE_IMPACT-2017_R2.exe
copy C:\vagrant\impact\CORE_IMPACT_3rdparty.exe c:\temp\CORE_IMPACT_3rdparty.exe
c:\vagrant\impact\UnattendedInstall.exe -v v:PASSPHRASE:ZCSJB7-U1ZWYH-48OYGZ-MJX3LE-CUV6XK -i c:\temp\CORE_IMPACT-2017_R2.exe -x c:\vagrant\impact\impact.xml
