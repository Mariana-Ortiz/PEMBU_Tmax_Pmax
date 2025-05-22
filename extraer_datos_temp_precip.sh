#!/bin/bash

###CODIGO PARA LEER ARCHIVOS DEL PROYECTO PEMBU###
### Alumna: Mariana Yolanda Ortiz Hernández
###HERRAMIENTAS COMPUTACIONALES
## PROFESORES: Lic. Pedro Damian, Maestra Dulce Moro Herrera.
# Definimos el nombre del archivo de salida donde se guardarán todos los datos combinados.
OUTPUT="tmax_pmax_pembu.csv"

# Escribimos la primera línea del archivo, que contiene los nombres de las columnas (encabezado).
echo "Estacion,Longitud,Latitud,Tmax,Pmax,Date" > "$OUTPUT"
# Esta es la ruta donde están guardados todos los archivos de datos.
BASE="/LUSTRE/cursos/2025/semestre2/gnulinux/a.8134/PEMBU"
# Vamos a recorrer todas las estaciones, que van de ENP1 a ENP9.
for ENP in {1..9}; do
  ESTACION="ENP$ENP"  # Creamos el nombre de la estación, por ejemplo ENP1, ENP2, etc.
  # Recorremos los 12 meses del año (01 a 12).
  for MES in {01..12}; do
    # Formamos el nombre completo del archivo que queremos leer.
    ARCHIVO="$BASE/2022-$MES-$ESTACION-L1.CSV"
 # Verificamos si el archivo realmente existe antes de intentar leerlo.
    if [[ -f "$ARCHIVO" ]]; then
# Buscamos la latitud dentro del archivo. Se asume que está en las primeras líneas (encabezado).
      LAT=$(grep -i "Lat" "$ARCHIVO" | grep -oP "Lat\s+\K[0-9.]+")
# Buscamos la longitud de forma similar.
      LON=$(grep -i "Lon" "$ARCHIVO" | grep -oP "Lon\s+\K[0-9.-]+")
# Ahora buscamos la temperatura máxima (Tmax).
# Usamos 'tail -n +10' para saltarnos las primeras 9 líneas (encabezado y metadatos).
# awk revisa la columna 2 (temperatura), y va guardando el valor más alto.
      Tmax=$(tail -n +10 "$ARCHIVO" | awk -F',' '{if($2 != "") if(max == "" || $2 > max) max = $2} END {print max}')
# Hacemos lo mismo con la columna 9, que corresponde a la precipitación (Pmax).
      Pmax=$(tail -n +10 "$ARCHIVO" | awk -F',' '{if($9 != "") if(max == "" || $9 > max) max = $9} END {print max}')
# Finalmente, escribimos una nueva línea en el archivo de salida con los datos de esta estación y mes.
      echo "$ESTACION,$LON,$LAT,$Tmax,$Pmax,2022-$MES" >> "$OUTPUT"
    fi
  done
done

