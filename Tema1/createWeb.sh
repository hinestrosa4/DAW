#!/bin/bash

echo "<!DOCTYPE html><html lang=en><head><meta charset=UTF-8><meta http-equiv=X-UA-Compatible content=IE=edge><meta name=viewport content=width=device-width, initial-scale=1.0><title>$1</title></head><body><h1>Titulo de ejemplo de la Página</h1><header><p style=color:blue><b>Cabecera de ejemplo</b></p></header><p>Parrafo de Ejemplo de la nueva pagina</p></body></html>" > /var/www/html/$1.html
echo "La pagina $1 se creo correctamente"
