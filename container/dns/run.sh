#!/bin/sh

if [ $ENABLED -eq 1 ]
then
  named -f
else
  sleep 365d
fi
