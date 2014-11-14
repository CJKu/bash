#!/bin/bash

_get_device_addr ()
{
  local output="$(adb shell ip -f inet addr show wlan0 2>/dev/null | grep inet)"
  local ip="$(echo ${output-""} | sed \
    "s/[[:blank:]]*inet[[:blank:]]*\([[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*\).*/\1/")"

  echo $ip
}

ip_address=$(_get_device_addr)
if [ -n "$ip_address" ]
then
  adb tcpip 5555
  adb connect $ip_address
fi
