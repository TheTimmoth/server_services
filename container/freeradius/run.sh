#!/bin/sh

if [ $ENABLED -eq 1 ]
then
  radiusd -f -l stdout
else
  sleep 365d
fi