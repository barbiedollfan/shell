#!/bin/bash
target_brightness=10
current_brightness=$(brightnessctl get)
brightnessctl -s set "${current_brightness}"

while [ "$current_brightness" -gt "$target_brightness" ]; do
    current_brightness=$((current_brightness - 1250))
    brightnessctl set "${current_brightness}"
    sleep 0.005 
done
