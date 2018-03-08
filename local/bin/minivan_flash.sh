#!/bin/bash
[[ -z "$1" ]] && exit 1
sudo dfu-programmer atmega32u4 erase
sudo dfu-programmer atmega32u4 flash "$1"
sudo dfu-programmer atmega32u4 start
