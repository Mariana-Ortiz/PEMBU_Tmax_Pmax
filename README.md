# PEMBU_Tmax_Pmax
# Proyecto PEMBU - GNULinux 2025-2

Este repositorio contiene los scripts desarrollados para analizar datos de las estaciones meteorológicas del programa PEMBU (UNAM), usando herramient>
## Scripts incluidos

### 🔹 `extraer_datos_temp_precip.sh`
Script en Bash que:

- Lee los archivos mensuales de cada estación (PEMBU).
- Extrae latitud, longitud, temperatura máxima (`Tmax`) y precipitación máxima (`Pmax`).
- Genera el archivo `tmax_pmax_pembu.csv` con la estructura requerida.
- Dentro del código viene toda la explicación detallada

### 🔹 `tmax_pmax_pembu.csv`
Script en Bash que contiene cada los valores de Tmax y Pmax para cada una de las estaciones ENP (de la 1 a la 9)

### 🔹 `graficar.py`
Script en Python (usando pandas, matplotlib, geopandas) que:

- Lee el CSV generado anteriormente.
- Produce gráficas mensuales de `Tmax` y `Pmax` por estación.

## 📊 Ejemplo de gráficas generadas

![Ejemplo Tmax](imagenes/Tmax_2022-01.png)
![Ejemplo Pmax](imagenes/Pmax_2022-01.png)

## ⚙️ Requisitos
- Python 3.10
- Micromamba o Conda
- Paquetes: `pandas`, `geopandas`, `matplotlib`, `numpy`, `scipy`

🧾 Descripción del trabajo realizado

En este proyecto desarrollé una solución automatizada para procesar y graficar datos meteorológicos del programa PEMBU, con base en los archivos .CSV proporcionados para cada estación y mes del año 2022.

🔧 Procesamiento de datos en Bash

Primero, elaboré un script en Bash que recorre automáticamente los archivos correspondientes a las nueve estaciones (ENP1 a ENP9) y los doce meses del año. Este script:
Extrae la latitud y longitud desde el encabezado de cada archivo.
Identifica los valores de temperatura máxima (Tmax) desde la segunda columna y precipitación máxima (Pmax) desde la novena columna.
Genera un archivo consolidado llamado tmax_pmax_pembu.csv, que contiene por fila: la estación, ubicación, valores máximos y la fecha del mes correspondiente.
Utiliza encabezados estandarizados para asegurar compatibilidad con el script de graficación.

🐍 Configuración del entorno Python
Para poder ejecutar el script graficar.py (provisto en el repositorio del curso), instalé y configuré un entorno de Python usando Micromamba, ya que este método permite mantener un entorno limpio con las bibliotecas necesarias. Instalé:

pandas
geopandas
matplotlib
scipy
numpy

Activé el entorno antes de correr los scripts Python.

📈 Generación de gráficas

Con el entorno listo y el archivo CSV generado, ejecuté el script graficar.py para crear gráficas de Tmax y Pmax. Durante este proceso corregí algunos errores del código original, como:
Cambiar Fecha por Date en el CSV para que el script pudiera reconocer correctamente la columna de fechas.
Corregir una variable mal escrita (Date sin definir, cuando debía ser date).
Declarar la codificación UTF-8 en el script para evitar errores por acentos o caracteres especiales.
Las gráficas generadas muestran la variación mensual de temperatura máxima y precipitación máxima por estación.

🌐 Publicación del proyecto

Finalmente, creé un repositorio público en GitHub donde subí:
El script en Bash (procesar_datos.sh)
El script de graficación (graficar.py)
El archivo CSV generado (tmax_pmax_pembu.csv)

Este documento README.md

Algunas imágenes resultantes de las gráficas

Esto permite que cualquier usuario pueda reproducir el análisis o extenderlo con nuevas variables.
## 🖥️ Ejecución

```bash
bash procesar_datos.sh
python3 graficar.py --file tmax_pmax_pembu.csv --variable Pmax

python3 graficar2.py tmax_pmax_pembu.csv Tmax
python3 graficar2.py tmax_pmax_pembu.csv Pmax




