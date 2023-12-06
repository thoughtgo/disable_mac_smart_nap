# Purpose
Disable the Smart Nap features to fix battery drain issue in MacOS, and it's tested in Sonoma.

➜ pmset -g log | grep "Wake from"
2023-12-05 17:30:29 +0800 Wake                  Wake from Standby [CDNVA] : due to EC.PowerButton/UserActivity Assertion Using AC (Charge:100%)           
2023-12-06 08:31:41 +0800 Wake                  Wake from Standby [CDNVA] : due to EC.ACDetach/UserActivity Assertion Using AC (Charge:92%) 

# Source 
The script is inspired by https://forums.macrumors.com/threads/sleep-issues-in-sonoma.2406806/page-2

# Core Ideas
- Disable the feature of CoreSmartPowerNap
- Disable tcpkeepalive

# Usage
sh disable_mac_smart_nap.sh
reboot

# Troubleshooting tools.
pmset -g log | tail -n 500
pmset -g log | grep "Wake from"
