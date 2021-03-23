#!/bin/bash

run() {
  ejabberdctl foreground
}

install() {
  cp -r /etc/ejabberd/* /template
}
