# EJERCICIO 1
### Crea un script que añada un puerto de escucha en el fichero de configuración de Apache. El puerto se recibirá como parámetro en la llamada y se comprobará que no esté ya presente en el fichero de configuración.
'''
#!/bin/bash

grep "Listen $1" /etc/apache2/ports.conf >> /dev/null

if [ $? -eq 0 ]
then
echo "Este puerto ya existe"
else
echo "Listen $1" >> /etc/apache2/ports.conf
fi
'''
