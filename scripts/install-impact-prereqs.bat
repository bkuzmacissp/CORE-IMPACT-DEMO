	if not exist "C:\Windows\Temp\C:\Windows\Temp\vcredist_x86.exe" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe', 'C:\Windows\Temp\vcredist_x86.exe')" <NUL
)
cmd /c C:\Windows\Temp\vcredist_x86.exe /q
if not exist "C:\Windows\Temp\C:\Windows\Temp\wic_x64_enu.exe" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/6/4/5/645fed5f-a6e7-44d9-9d10-fe83348796b0/wic_x64_enu.exe', 'C:\Windows\Temp\wic_x64_enu.exe')" <NUL
)
cmd /c C:\Windows\Temp\wic_x64_enu.exe /quiet /norestart
if not exist "C:\Windows\Temp\dotNetFx40_Full_setup.exe" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/1/B/E/1BE39E79-7E39-46A3-96FF-047F95396215/dotNetFx40_Full_setup.exe', 'C:\Windows\Temp\dotNetFx40_Full_setup.exe')" <NUL
)
cmd /c C:\Windows\Temp\dotNetFx40_Full_setup.exe /q /norestart
if not exist "C:\Windows\Temp\SQLEXPR_x86_ENU.exe" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/5/2/9/529FEF7B-2EFB-439E-A2D1-A1533227CD69/SQLEXPR_x86_ENU.exe', 'C:\Windows\Temp\SQLEXPR_x86_ENU.exe')" <NUL
)
cmd /c C:\Windows\Temp\SQLEXPR_x86_ENU.exe  /q /HIDECONSOLE /ACTION=Install /IACCEPTSQLSERVERLICENSETERMS /FEATURES=SQL /INSTANCENAME=IMPACT /AGTSVCACCOUNT="NT AUTHORITY\NETWORK SERVICE" /SQLSVCACCOUNT="NT AUTHORITY\NETWORK SERVICE" /SQLSYSADMINACCOUNTS="BUILTIN\Administrators"
if not exist "C:\Windows\Temp\iisexpress_1_11_x86_en-US.msi" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.microsoft.com/download/D/C/4/DC4EC38C-A6AA-449D-9B19-7ABC6DF72B34/iisexpress_1_11_x86_en-US.msi', 'C:\Windows\Temp\iisexpress_1_11_x86_en-US.msi')" <NUL
)
msiexec /i C:\Windows\Temp\iisexpress_1_11_x86_en-US.msi /qn REBOOT=ReallySuppress
if not exist "C:\Windows\Temp\CRRuntime_12_3_mlb.msi" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://impact.coresecurity.com/setup/CRRuntime_12_3_mlb.msi', 'C:\Windows\Temp\CRRuntime_12_3_mlb.msi')" <NUL
)
msiexec /i C:\Windows\Temp\CRRuntime_12_3_mlb.msi /passive /norestart
