#!/bin/bash
#Usage: reboot after apply the tuning.
#Reference: https://forums.macrumors.com/threads/sleep-issues-in-sonoma.2406806/page-2

#Troubleshooting from log.
#pmset -g log | tail -n 500
#pmset -g log | grep DarkWake
#pmset -g log | grep "Wake Requests"
#pmset -g log | grep -e "Sleep.*due to" -e "Wake.*due to" | tail -10

sudo pmset restoredefaults
sudo pmset schedule cancelall
sudo pmset repeat cancel
sudo chflags schg /Library/Preferences/SystemConfiguration/com.apple.AutoWake.plist

#Enable sleep and put into sleep after 10 mins if no actions.
sudo pmset -a sleep 10 
sudo pmset -a disablesleep 0

#Create new powerd file to disable power nap
sudo mkdir -p /Library/Preferences/FeatureFlags/Domain/
sudo defaults write /Library/Preferences/FeatureFlags/Domain/powerd.plist CoreSmartPowerNap -dict Enabled -bool NO
sudo defaults read /Library/Preferences/FeatureFlags/Domain/powerd.plist 

sudo pmset -a tcpkeepalive 0 
sudo pmset -a powernap 0
sudo pmset -a standby 1
sudo pmset -a autopoweroff 1 
sudo pmset -a womp 0 
sudo pmset -a darkwakes 0 
sudo pmset -a lessbright 0 
sudo pmset -a halfdim 0 
sudo pmset -a ttyskeepawake 0 
sudo pmset -a ring 0 
sudo pmset -a networkoversleep 0
sudo pmset -a proximitywake 0
sudo pmset -a displaysleep 9 
sudo pmset -a disksleep 9 

#Default is 3
sudo pmset -a hibernatemode 25



#Delay in second
sudo pmset -a standbydelay 1800 
sudo pmset -a autopoweroffdelay 1860 
sudo pmset -a highstandbythreshold 75
sudo pmset -a standbydelayhigh 1800
sudo pmset -a standbydelaylow 1800
sudo nvram boot-args="darkwake=0"

#Not sure if it's related.
#sudo defaults delete /Library/Preferences/com.apple.mDNSResponder.plist
#sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
#sudo defaults read /Library/Preferences/com.apple.mDNSResponder.plist
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.PowerManagement SystemPowerSettings -dict SleepDisabled -bool NO TCPKeepAlive -bool NO TCPKeepAliveDuringSleep -bool NO NotificationWake  -bool NO
#sudo defaults read /Library/Preferences/SystemConfiguration/com.apple.PowerManagement

#Check status after change
pmset -g sched
pmset -g assertions
pmset -g custom

#How to disable SIP
#Restart, and press Command+R to recovery mode, select Terminal
#csrutil disable  
#csrutil authenticated-root disable

