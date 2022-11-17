# EJERCICIO 1
### Crea un script que añada un puerto de escucha en el fichero de configuración de Apache. El puerto se recibirá como parámetro en la llamada y se comprobará que no esté ya presente en el fichero de configuración.
```
#!/bin/bash

grep "Listen $1" /etc/apache2/ports.conf >> /dev/null

if [ $? -eq 0 ]
then
echo "Este puerto ya existe"
else
echo "Listen $1" >> /etc/apache2/ports.conf
fi
```

# EJERCICIO 2
### Crea un script que añada un nombre de dominio y una ip al fichero host. Debemos comprobar que no existe dicho dominio

``` 
#!/bin/bash

grep -w "$1" /etc/hosts >> /dev/null

if [ $? -eq 0 ]
then
echo "Este dominio ya existe"
else
echo "$2 $1" >> /etc/hosts
echo "Dominio $2 $1 añadido correctamente"
fi
```

# EJERCICIO 3
### Crea un script que nos permita crear una página web con un título, una cabecera y un mensaje

``` 
#!/bin/bash

echo "<!DOCTYPE html><html lang=en><head><meta charset=UTF-8><meta http-equiv=X-UA-Compatible content=IE=edge><meta name=viewport content=width=device-width, initial-scale=1.0><title>$1</title></head><body><h1>Titulo de ejemplo de la Página</h1><header><p style=color:blue><b>Cabecera de ejemplo</b></p></header><p>Parrafo de Ejemplo de la nueva pagina</p></body></html>" > /var/www/html/$1.html
echo "La pagina $1 se creo correctamente"
```
