#!/bin/bash
if [ `id -u` != 0 ]
then
    echo "Please run  as su"
    exit 1
    