mkdir windows
mkdir winre
mkdir all_drv

copy install.wim install.wim.original

Dism /Get-WimInfo /WimFile:install.wim
Dism /Mount-Image /ImageFile:install.wim /Index:1 /MountDir:%cd%\windows

Dism /Get-WimInfo /WimFile:%cd%\windows\windows\system32\recovery\winre.wim
Dism /Mount-Image /ImageFile:%cd%\windows\windows\system32\recovery\winre.wim /Index:1 /MountDir:%cd%\winre

pnputil /export-driver * all_drv

for /R all_drv %%f in (*.inf) do Dism /Image:%cd%\winre /Add-Driver /Driver:%%f
Dism /Unmount-Image /MountDir:%cd%\winre /Commit

for /R all_drv %%f in (*.inf) do Dism /Image:%cd%\windows /Add-Driver /Driver:%%f
Dism /Unmount-Image /MountDir:%cd%\windows /Commit
