#!/bin/sh

dnssec-keygen -a HMAC-SHA512 -b 512 -n HOST dhcp_update
cut -c 31- Kdhcp_update.*.key