#!/bin/bash

# This file should be called by a LaunchAgent
# Its goal is to ensure SplashBuddy only executes when user is on the desktop.

# I suggest you create a Policy to Remove and uninstall the LaunchAgent
# We cannot do it here as LaunchAgent are executed by the user.

loggedInUser=$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')
app="/Library/Application Support/SplashBuddy/SplashBuddy.app"
doneFile="/Users/${loggedInUser}/Library/Containers/io.fti.SplashBuddy/Data/Library/.SplashBuddyDone"

# Check if:
# - SplashBuddy binary exists (is fully installed)
# - User is in control (not _mbsetupuser)
# - User is on desktop (Finder process exists)
# - Application is not already running

function IsNotRunning()
{
    pgrep "SplashBuddy" && return 0 || return 1
}

if IsNotRunning \
	&& [ $(codesign --verify ${app}) ] \
	&& [ "$loggedInUser" != "_mbsetupuser" ] \
	&& [ ! $(pgrep Finder) ] \
	&& [ ! -f "${doneFile}" ]; then

    open -a "$app"
	
fi

exit 0
