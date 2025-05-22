#!/bin/bash

# Paso 1: Buscar todas las estaciones de la Línea 1 para la fecha 2021-01-01
# Buscamos en el archivo afluenciastc_desglosado_03_2025.csv
# Primero filtramos por fecha (2021-01-01)
# Después solo las que tienen exactamente "Línea 1"
# Luego extraemos el campo 5 (que es el nombre de la estación)
# Quitamos duplicados con uniq para tener solo una vez cada estación
# Guardamos esa lista en un archivo llamado "estaciones"
grep 2021-01-01 afluenciastc_desglosado_03_2025.csv | grep -w "Línea 1" | cut -d, -f5 | uniq > estaciones

# Paso 2: Guardar todas las filas que corresponden a Línea 1 y fecha 2021-01-01
# Pero esta vez desde el archivo afluenciastc_desglosado_02_2025.csv (que tiene los ingresos)
# Guardamos esas filas en un archivo llamado "ingresos"
grep 2021-01-01 afluenciastc_desglosado_02_2025.csv | grep -w "Línea 1" > ingresos

# Paso 3: Para cada estación en la lista "estaciones"
# Buscamos todas las líneas en "ingresos" que tienen esa estación
# Extraemos el campo 7 que es el número de ingresos
# Sumamos todos esos ingresos con awk
# Imprimimos el nombre de la estación seguido del total de ingresos
while read EST; do
  echo -n "$EST: "                         # Imprime el nombre de la estación seguido de dos puntos
  grep "$EST" ingresos | cut -d, -f7 | awk '{s+=$1} END {print s}'  # Suma y muestra los ingresos
done < estaciones


### Qué es lo que hace cada comando
a) ¿Qué resultado se obtiene al eliminar grep -w "Línea 1" de la secuencia de
comandos? explique
Respuesta: Si quitamos esa parte, entonces ya no estoy filtrando solo la Línea 1 Lo cual significa que voy a tomar estaciones de todas las líneas del metro para la fecha que estoy viendo, no solo las de la Línea 1. 

b) A partir del razonamiento anterior, ¿qué modificación debe realizarse para obtener el total de ingresos de todas las estaciones (todas las líneas del metro) para el mes de
enero de 2021?
Como ahora quiero todo enero, cambio la fecha de 2021-01-01 a solo 2021-01, así incluyo cualquier día de enero.
Y también quito el filtro de la Línea 1 para que incluya todas las estaciones de todas las líneas.

c) A partir del resultado anterior, ¿qué modificaciones deben realizarse para obtener el
total de ingresos de todas las estaciones (todas la líneas del metro) para el año 2021?
En lugar de usar 2021-01 para enero, uso solo 2021 para que me tome todos los días del año.
Sigo sin poner filtro de línea para incluir todas.
d) Reportar la estación con más número de ingresos para los años 2021, 2022, 2023, 2024
Para cada año, filtro con grep ese año.
Luego calculo el total de ingresos para cada estación y elijo la que tenga el número más alto.
Así sé cuál estación fue la que más gente tuvo en cada año.
e) A partir de los resultados anteriores, ¿ qué modificaciones deben realizarse para
obtener el total de ingresos de todas las estaciones para todos los registros en el
archivo, en otras palabras para todos los años registrados 2021 .. 2025
Solo quito cualquier filtro de fecha.
Así tomo todos los datos que haya en el archivo, sin importar el año, y sumo los ingresos de todas las estaciones.
