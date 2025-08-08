#!/bin/bash
INTERFACE="" #PUT YOUR INTERFACE NAME HERE
sudo ifconfig "${INTERFACE}" down
sudo macchanger -r "${INTERFACE}"
rfkill unblock wifi
sudo ifconfig "${INTERFACE}" up
