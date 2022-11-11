#!/bin/bash

grep -w "$1" /etc/hosts >> /dev/null

if [ $? -eq 0 ]
then
echo "Este dominio ya existe"
else
echo "$2 $1" >> /etc/hosts
echo "Dominio $2 $1 añadido correctamente"
fi
