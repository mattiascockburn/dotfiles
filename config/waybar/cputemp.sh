#!/bin/bash
sensors -j acpitz-acpi-0 | jq '.["acpitz-acpi-0"]["temp1"]["temp1_input"]'
