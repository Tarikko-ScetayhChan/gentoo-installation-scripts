	:: ####### windows-nt-dism-uefi-install.cmd
	:: ####### https://github.com/Tarikko-ScetayhChan/tascscripts/

	:: ##### Read and edit this script before you run it.

	:: ### partition the disk
	:: # Edit the windows-nt-dism-uefi-installdiskpart.txt file if necessary.
diskpart /s windows-nt-dism-uefi-installdiskpart.txt

	:: ### apply the image
	:: # Edit the /ImageFile option to yours.
	:: # Edit the /Index option to yours.
DISM.exe /Apply-Image /ImageFile:"D:\Sources\install.esd" /Index:4 /ApplyDir:W:\

	:: ### add boot options
bcdboot w:\windows /h uefi /s s: /l zh-cn

	:: ### reboot
	:: # Uncomment the command below to reboot
:: Wpeutil Reboot
