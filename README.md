# PEMBU_Tmax_Pmax
# Proyecto PEMBU - GNULinux 2025-2

Este repositorio contiene los scripts desarrollados para analizar datos de las estaciones meteorológicas del programa PEMBU (UNAM), usando herramient>
## Scripts incluidos

### 🔹 `variables_temp_precip_pembu.sh`
Script en Bash que:

- Lee los archivos mensuales de cada estación (PEMBU).
- Extrae latitud, longitud, temperatura máxima (`Tmax`) y precipitación máxima (`Pmax`).
- Genera el archivo `tmax_pmax_pembu.csv` con la estructura requerida.

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

## 🖥️ Ejecución

```bash
bash procesar_datos.sh
python graficar.py --file tmax_pmax_pembu.csv --variable Tmax
python graficar.py --file tmax_pmax_pembu.csv --variable Pmax


