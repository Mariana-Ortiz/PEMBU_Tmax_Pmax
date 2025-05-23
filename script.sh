#!/bin/bash

####CODIGO PARA LEER ARCHIVOS DEL PROYECTO PEMBU###
### Alumna: Mariana Yolanda Ortiz Hernández
###HERRAMIENTAS COMPUTACIONALES
## PROFESORES: Lic. Pedro Damian, Maestra Dulce Moro Herrera.

### Este es un script para obtener los datos de temperatura máxima (Tmax) y precipitación maxima (Pmax)de las estaciones del proyecto PEMBU.
# y se guarda todo en un archivo CSV llamado 'tmax_pmax_pembu2.csv'.
### Se hace uso de comandos y estructuras vistas en clase como: bucles for, condicionales if, concatenación de strings, 
# verificación de existencia de archivos, y redirección de salida.
# El objetivo es generar un archivo combinado que contenga todos los datos en un archivo en formato CSV.

# Para iniciar, definimos el nombre del archivo de salida donde se guardarán todos los datos combinados.
# Este es un script para obtener los datos de temperatura máxima (Tmax) y precipitación maxima (Pmax)de las estaciones del proyecto PEMBU.
# y se guarda todo en un archivo CSV llamado 'tmax_pmax_pembu2.csv'.


# Definimos el nombre del archivo donde voy a guardar todos los resultados combinados.
OUTPUT="tmax_pmax_pembu2.csv"
# Escribimos la primera línea del archivo, que son los nombres de las columnas (el encabezado).
echo "Estacion,Longitud,Latitud,Tmax,Pmax,Date" > "$OUTPUT"
# Esta es la ruta base donde están guardados todos los archivos CSV de cada estación y mes.
BASE="/LUSTRE/cursos/2025/semestre2/gnulinux/a.8134/PEMBU"
# Para revisar los datos de las 9 estaciones correspondientes a las ENP de ENP1 a ENP9, hacemos uso de la estructura del for.
for ENP in {1..9}; do
# Con la variable ESTACION, se agrega  el nombre de la estación, por ejemplo ENP1, ENP2, etc.
  ESTACION="ENP$ENP"
# Cada escuela contiene 12 archivos que corresponden 1 por mes así que se tiene que revisar los 12 meses del año, del 01 al 12 de la siguiente forma.
  for MES in {01..12}; do
# A continuación, el nombre completo del archivo que quiero revisar, por ejemplo: 2022-01-ENP1-L1.CSV
    ARCHIVO="$BASE/2022-$MES-$ESTACION-L1.CSV"
# Se revisa si el archivo realmente existe.
    if [[ -f "$ARCHIVO" ]]; then
      # Buscamos la latitud dentro del encabezado del archivo (normalmente en las primeras líneas).
      LAT=$(grep -i "Lat" "$ARCHIVO" | grep -oP "Lat\s*[:=]?\s*\K[0-9.]+")
# Igual, para la longitud dentro del encabezado.
      LON=$(grep -i "Lon" "$ARCHIVO" | grep -oP "Lon\s*[:=]?\s*\K[-0-9.]+")
# Para la temperatura máxima (Tmax) entre todos los datos, que están desde la línea 10 en adelante, usamos el comando tail.
      # La columna 2 contiene las temperaturas. awk busca el valor más alto (el máximo).
      Tmax=$(tail -n +10 "$ARCHIVO" | awk -F',' '{if($2 != "" && $2+0==$2) if(max == "" || $2 > max) max = $2} END {print max}')
#Lo mismo para la precipitación máxima (Pmax), que está en la columna 9.
      Pmax=$(tail -n +10 "$ARCHIVO" | awk -F',' '{if($9 != "" && $9+0==$9) if(max == "" || $9 > max) max = $9} END {print max}')
# Solo se escribe al archivo si están todos los datos (nada vacío).
      if [[ -n "$LAT" && -n "$LON" && -n "$Tmax" && -n "$Pmax" ]]; then
#Finalmente, para el encabezado donde iran los datos numéricos de las variables que acabamos de calcular, escribimos una línea con todos los datos: estación, longitud, latitud, Tmax, Pmax, y la fecha (yo le pongo día 01 por simplicidad).
        echo "$ESTACION,$LON,$LAT,$Tmax,$Pmax,2022-$MES-01" >> "$OUTPUT"
      fi
    fi
  done
done
## HASTA AQUI TERMINA EL CÓDIGO ##
