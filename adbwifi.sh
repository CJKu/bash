#!/bin/bash

# Read ip address of the attached device.
_get_device_addr ()
{
  local output="$(adb shell ip -f inet addr show wlan0 | grep "^[[:blank:]]*inet")"
  if [ -z "$output" ]; then
    exit 1
  fi

  local address_pattern="[[:blank:]]*inet[[:blank:]]*\([[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*\).*"
  local address="$(echo "$output" | sed "s/${address_pattern}/\1/")"

  if [ -z "$address" ]; then
    exit 1
  fi

  echo $address
}

# Read IP address.
ip_address=$(_get_device_addr)

# Connect the target device via WIFI
if [ -n "$ip_address" ]
then
  adb tcpip 5555
  adb connect $ip_address
fi

exit 0
