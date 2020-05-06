#!/bin/sh

if [ $ENABLED -eq 1 ]
then
  named -g
else
  sleep 365d
fi