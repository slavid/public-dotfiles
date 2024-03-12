#!/usr/bin/python3

###
# Razer Viper Ultimate (Wireless) and Razer Mouse Dock connected.
###

from openrazer.client import DeviceManager
import time

while True:
    devicemgr = DeviceManager()
    devicemgr.sync_effects = False
    devices = devicemgr.devices
    ### For debugging purposes you may want to print out the names
    # print ("Devices 0 name: ", devices[0].name)
    # print ("Devices 1 name: ", devices[1].name)

    # ad-hoc cmd to check battery level and charging status: python3 -c "import openrazer.client; a = openrazer.client.DeviceManager().devices[0]; print(a.is_charging, a.battery_level)"
    
    if devices[0].name == "Razer Viper Ultimate (Wireless)":
        mouse = devices[0]
        dock = devices[1]
    else:
        mouse = devices[1]
        dock = devices[0]
    
    # print(mouse.is_charging)

    if mouse.is_charging:
        if mouse.battery_level > 75:
            # Static Green
            dock.fx.breath_single(0, 255, 0)
            ### For debugging purposes you may want to print out the battery level
            # print ("Battery level > 75: ", mouse.battery_level)
        elif (mouse.battery_level > 50) and (mouse.battery_level <= 75):
            # Static Yellow
            dock.fx.breath_single(255, 255, 0)
            ### For debugging purposes you may want to print out the battery level
            # print("Battery > 50 and <= 75: ", mouse.battery_level)
        elif (mouse.battery_level > 25) and (mouse.battery_level <= 50):
            # Static Orange
            dock.fx.breath_single(255, 160, 0)
            ### For debugging purposes you may want to print out the battery level
            # print("Battery > 25 and <= 50: ", mouse.battery_level)
        elif mouse.batter_level <= 25:
            # Static Red
            dock.fx.breath_single(255, 0, 0)
            ### For debugging purposes you may want to print out the battery level
            # print("Battery <= 25: ", mouse.battery_level)
    else:
        if mouse.battery_level > 75:
                # Static Green
                dock.fx.static(0, 255, 0)
                ### For debugging purposes you may want to print out the battery level
                # print ("Battery level > 75: ", mouse.battery_level)
        elif (mouse.battery_level > 50) and (mouse.battery_level <= 75):
            # Static Yellow
            dock.fx.static(255, 255, 0)
            ### For debugging purposes you may want to print out the battery level
            # print("Battery > 50 and <= 75: ", mouse.battery_level)
        elif (mouse.battery_level > 25) and (mouse.battery_level <= 50):
            # Static Orange
            dock.fx.static(255, 160, 0)
            ### For debugging purposes you may want to print out the battery level
            # print("Battery > 25 and <= 50: ", mouse.battery_level)
        elif mouse.batter_level <= 25:
            # Static Red
            dock.fx.static(255, 0, 0)
            ### For debugging purposes you may want to print out the battery level
            # print("Battery <= 25: ", mouse.battery_level)
    time.sleep(300) # 5 minutes