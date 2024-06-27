
global frontApp, frontAppName, windowTitle

on getActiveWindowName()
	try
		set windowTitle to ""
		tell application "System Events"
			set frontApp to first application process whose frontmost is true
			set frontAppName to name of frontApp
			tell process frontAppName
				tell (1st window whose value of attribute "AXMain" is true)
					set windowTitle to value of attribute "AXTitle"
				end tell
			end tell
		end tell
		
		return windowTitle
	on error errorMessage number errorNumber
		return "-"
	end try
	
end getActiveWindowName

global currentLayoutName

on setKeyboardLayout(layoutName)
	-- if {currentLayoutName is not layoutName} then
	-- say layoutName
	do shell script "/usr/local/bin/InputSourceSelector select com.apple.keylayout." & layoutName
	set currentLayoutName to layoutName
	-- end if
end setKeyboardLayout

set currentLayoutName to ""
set previousWindowName to ""
set currentWindowName to ""


repeat
	set currentWindowName to getActiveWindowName()
	-- do shell script "echo 'Current frontAppName name: " & frontAppName & "' >> /tmp/script.log"
	-- say frontAppName
	
	if currentWindowName is not previousWindowName then
		if {frontAppName is equal to "prl_client_app" and currentWindowName starts with "UbuntuVM"} then
			setKeyboardLayout("Polish")
		else
			setKeyboardLayout("PolishPro")
		end if
		set previousWindowName to currentWindowName
	end if
	
	delay 1
	
end repeat
