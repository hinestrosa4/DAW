# PROYECTO SERVIDOR WEB

### 1. Instalación del servidor web apache. Usaremos dos dominios mediante el archivo hosts: centro.intranet y departamentos.centro.intranet. El primero servirá el contenido mediante wordpress y el segundo una aplicación en Python

&ensp;&ensp; **1.1. Instalación Servidor Web Apache**

Antes de empezar a instalar nuestro servidor web Apache, debemos actualizar el sistema, para ello usamos estas dos simples instrucciones.
```bash
sudo apt update || apt upgrade
```

Una vez actualizado nuestro servidor, vamos a proceder a instalar el servidor web apache y comprobamos que se ha instalado correctamente.
```bash
sudo apt install apache2 -y
```
```bash
systemctl status apache2
```

Vemos que podemos entrar sin ningún tipo de problema.

![CheckApache](images/3.png)

&ensp;&ensp; **1.2. Instalación de MySql y PHP**

Para instalar MySql vamos a ejecutar el siguiente comando
```bash
sudo apt install mysql-server
```

Una vez instalado, para saber si lo hicimos correctamente ponemos en la linea de comandos la siguiente instrucción
```bash
mysql
```

A continuación, vamos a pasar a instalar PHP, para ellos ejecutamos el sigueinte comando para instalar algunas librerias necesarias
```bash
apt install php libapache2-mod-php php-mysql
```

Comprobamos que se ha instalado correctamente viendo la version de PHP que hemos instalado
```bash
php -v
```

&ensp;&ensp; **1.3. Configurar Dominios**

Para crear un dominio tenemos que dirigirnos al fichero **/etc/hosts**, una vez ahí, debemos poner nuestra ip local y el nombre del dominio que queremos crear, como en el siguiente ejemplo

```bash
sudo nano /etc/hosts
```

![/etc/hosts](images/8.png)

### 2. Instala y Configura Wordpress

Para la instalación correcta de Wordpress, tenemos que dirigirnos **/var/www/html/**, una vez dentro, debemos crear un directorio donde se va almacenar nuestra página de Wordpress

```bash
sudo mkdir /var/www/html/pagWordPress
```

El segundo paso que debemos seguir, es crear el fichero de configuracion de nuestra página Wordpress. Para ello, nos dirigimos a **/etc/apache2/sites-available/centro.intranet.conf**, en mi caso el nombre del fichero es el nombre de mi dominio + .conf

```bash
sudo nano /etc/apache2/sites-available/centro.intranet.conf
```

Y ponemos el siguiente contenido

```apache
<VirtualHost *:80>
  ServerName centro.intranet
  ServerAlias centro.intranet
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/html/pagWordPress
  
<Directory /var/www/html/padWordPress/>
  AllowOverride All
</Directory>

ErrorLog ${APACHE_LOG_DIR}/pagWordPress_error.log
CustomLog ${APACHE_LOG_DIR}/pagWordPress_access.log combined
</VirtualHost>
```

Cuando hemos creado un nuevo fichero .conf en los directorios de configuracion de apache, debemos comprobar si no hay ningun error sintáctico en la configuración, habilitar el nuevo modulo que hemos creado y reiniciar apache

```bash
a2ensite centro.intranet
```
```bash
apache2ctl configtest
```
```bash
systemctl restart apache2
```

A continuación, vamos a ejecutar algunos comandos en mysql para crear una base de datos y un usuario administrador para Wordpress. Para ello, entramos en mysql

```bash
mysql
```

Una vez dentro, vamos a crear la base de datos para Wordpress, en mi caso se llamará **wordpress**

```mysql
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
```

Creamos el usuario administrador, en este caso, se llamará **wordpressuser**

```mysql
CREATE USER 'wordpressuser'@'%' IDENTIFIED WITH mysql_native_password BY '123';
```

Por último, vamo a asignarle los permisos correspondientes

```mysql
GRANT ALL ON wordpress.* TO 'wordpressuser'@'%';
```
```mysql
FLUSH PRIVILEGES;
```

Para salir de mysql ponemos

```mysql
exit;
```

Una vez configurada la base de datos de nuestra página de Wordpress, vamos a instalar algunos modulos de PHP necesarios para la creacion de la página

```bash
sudo apt install curl php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y
```

Reiniciamos apache de nuevo para guardar todos los cambios

```bash
systemctl restart apache2
```

Vamos a empezar con la instalación de Wordpress. Vamos a dirigirnos a un directorio temporal para instalar todas las librerias de Wordpress

```bash
cd /tmp
```
```bash
sudo curl -O https://wordpress.org/latest.tar.gz
```

Lo descomprimimos

```bash
tar xzvf latest.tar.gz
```

Y creamos el archivo .htaccess para que podamos acceder a la página y no nos de el famoso error **Forbidden**

```bash
touch /tmp/wordpress/.htaccess
```

Copiamos la plantilla de configuración al fichero config.php

```bash
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
```

Creamos el directorio para actualizaciones de Wordpress y copiamos Wordpress a la carpeta web para nuestro proyecto

```bash
mkdir /tmp/wordpress/wp-content/upgrade
```
```bash
sudo cp -a /tmp/wordpress/. /var/www/html/pagWordPress
```

Aplicamos los siguientes permisos a la carpeta de nuestra web
```bash
sudo chown -R www-data:www-data /var/www/html/pagWordPress
sudo find /var/www/html/pagWordPress -type d -exec chmod 750 {} \;
sudo find /var/www/html/pagWordPress -type f -exec chmod 640 {} \;
```

A continuación, vamos a generar unas claves necesarias para ponerlas en un archivo de cofiguracion de Wordpress. Para ello, ejecutamos el siguiente comando y copiamos todo el contenido resultante

```bash
curl -s https://api.wordpress.org/secret-key/1.1/salt/
```


```apache
root@rafa:/tmp# curl -s https://api.wordpress.org/secret-key/1.1/salt/ 
define('AUTH_KEY','XCg6.;1>5A@w!%?:M[+.;SyD?U030|iv^*]D2dR-`@GL82_C*Yv^$aQ6}dg)IeFi');
define('SECURE_AUTH_KEY','G=vlH7{ZBy6!7(PJ{S4<F~Doo_wS67]4,sN;-k@&-R%QWa$/SHr|BEZDGm;5LC~#');
define('LOGGED_IN_KEY','$[Cooii&tfwggfy+]#JT8I;;oh9u*CQTDwTazhzn[9]mfBu,@YR]bz!0]W|Swsx');
define('NONCE_KEY','ubu]6N0Z%sJ~e(<M+ODOR|J[6ZprN}6C]]nPxq72P{fBB+RZ9!98;zsak8tJt-H');
define('AUTH_SALT','alo^Wpd72|eZ|M+MBxqC/;VdsFFS${*q2bc@hpU0=;,,~0Dn1H8YD4eYO|at-1');
define('SECURE_AUTH_SALT','F>E!OTTZ-5T+Qj4+15r?huI(>CS@vin]tj1zSr0*TAtn~Zzk:SB3+erZV GDV^');
define('LOGGED_IN_SALT','pa^5zh1/[k=[N{57*KjiP4esb-UtGpV*ziVk-d,3loJ[m]u;u%7k#xPR%Pb+N((');
define('NONCE_SALT','04M1C(0;010;jhXj(;4p5zx0s;;az^D00;P91Ycwuez'sh@&c<0)[_AP7B$!t8');
```

