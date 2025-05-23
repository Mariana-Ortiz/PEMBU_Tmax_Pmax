# PEMBU_Tmax_Pmax
# Proyecto PEMBU - GNULinux 2025-2

Este repositorio contiene los scripts desarrollados para analizar datos de las estaciones meteorológicas del programa PEMBU (UNAM), usando herramient>
## Scripts incluidos

### 🔹 `scrip.sh`
Script en Bash que:

- Lee los archivos mensuales de cada estación (PEMBU).
- Extrae latitud, longitud, temperatura máxima (`Tmax`) y precipitación máxima (`Pmax`).
- Genera el archivo `tmax_pmax_pembu2.csv` con la estructura requerida.
- Dentro del código viene toda la explicación detallada.

### 🔹 `tmax_pmax_pembu2.csv`
Script en Bash que contiene cada los valores de Tmax y Pmax para cada una de las estaciones ENP (de la 1 a la 9). 
- Cada fila corresponde a una observación para los 12 meses del año en una estación específica.
- Incluye coordenadas geográficas de cada estación, lo que permite realizar visualización geoespacial.
- Es utilizado como entrada en scripts de Python para generar mapas interpolados de variables meteorológicas.

### 🔹 `graficar3.py`
Script en Python (usando pandas, matplotlib, geopandas) que:

- Lee el CSV generado anteriormente.
- Produce gráficas mensuales de `Tmax` y `Pmax` por estación.

## 📊 Ejemplo de gráficas generadas

![Ejemplo Tmax](output_figures/temp_max_2022-05-01.png)
![Ejemplo Pmax](output_figures/prec_max_2022-02-01.png)

## ⚙️ Requisitos para poder correr los scripts:
Tener instalados
- Python 3.10
- Micromamba o Conda
- Paquetes: `pandas`, `geopandas`, `matplotlib`, `numpy`, `scipy`

🧾 Descripción del trabajo realizado

En este proyecto desarrollé una solución automatizada para procesar y graficar datos meteorológicos del programa PEMBU, con base en los archivos .CSV proporcionados para cada estación y mes del año 2022.

🔧 Procesamiento de datos en Bash

Primero, elaboré un script en Bash que recorre automáticamente los archivos correspondientes a las nueve estaciones (ENP1 a ENP9) y los doce meses del año. Este script:
Extrae la latitud y longitud desde el encabezado de cada archivo.
Identifica los valores de temperatura máxima (Tmax) desde la segunda columna y precipitación máxima (Pmax) desde la novena columna.
Genera un archivo consolidado llamado tmax_pmax_pembu2.csv, que contiene por fila: la estación, ubicación, valores máximos (Tmax y Pmax) y la fecha del mes correspondiente.
Utiliza encabezados estandarizados para asegurar compatibilidad con el script de graficación.

Para la configuración del entorno Python
Para poder ejecutar el script graficar3.py (provisto en el repositorio del curso), instalé y configuré un entorno de Python usando Micromamba, ya que este método permite mantener un entorno limpio con las bibliotecas necesarias. Las librerias instaladas y necesarioas fueron:

pandas
geopandas
matplotlib
scipy
numpy

Hay que asegurarse de activar correctamente el entorno de microbamba desde terminal antes de correr los scripts Python:
- eval "$(./bin/micromamba shell hook -s posix)"
- luego hacer desde terminal: micromamba activate

📈 Para la generación de gráficas

Con el entorno listo y el archivo CSV generado (tmax_pmax_pembu2.csv), se ejecutó el script graficar3.py para crear las gráficas de Tmax y Pmax. Durante este proceso corregí algunos errores del código original, como:
Cambiar Fecha por Date en el CSV para que el script pudiera reconocer correctamente la columna de fechas ya que originalmente yo en mi archivo de salida .csv. había nombrado así

En mi caso, tuve que declarar la codificación UTF-8 en el script para evitar errores por acentos o caracteres especiales.
Las gráficas generadas muestran la variación mensual de temperatura máxima y precipitación máxima por estación.

Desde terminal, escribimos los siguientes comandos:
## 🖥️ Ejecución


🌐 Publicación del proyecto

Finalmente, con todo el análisis de datos hecho, se hizo un repositorio público en GitHub donde subí y se puede encontrar:
El script en Bash (script.sh)
El script de graficación (graficar3.py)
El archivo CSV generado (tmax_pmax_pembu2.csv)
Las graficas de Tmax y Pmax y 
Este documento README.md

Con esto, se permite que cualquier usuario pueda reproducir el análisis o extenderlo con nuevas variables si así lo deseara.




