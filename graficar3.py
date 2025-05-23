
# -*- coding: utf-8 -*-
import pandas as pd
import geopandas as gpd
import matplotlib.pyplot as plt
from scipy.interpolate import griddata
import numpy as np
import warnings
import argparse
import os

warnings.filterwarnings('ignore')

def grafica(file, varname):
    graf_conf = {
        "Tmax": {
            "label": "Temperatura Máxima (°C)",
            "title": "Temperatura Máxima estaciones PEMBU",
            "file_out": "temp_max_"
        },
        "Pmax": {
            "label": "Precipitación máxima (mm)",
            "title": "Precipitación estaciones PEMBU",
            "file_out": "prec_max_"
        },
    }

    df = pd.read_csv(file)
    dates = df['Date'].unique()

    for date in dates:
        # Filtrar datos por fecha
        df_filtered = df[df['Date'] == date].reset_index(drop=True)

        # Rango de coordenadas
        lonmax = df_filtered.Longitud.max()
        lonmin = df_filtered.Longitud.min()
        latmax = df_filtered.Latitud.max()
        latmin = df_filtered.Latitud.min()

        # Resolución y malla
        x = np.arange(lonmin, lonmax, 0.01)
        y = np.arange(latmin, latmax, 0.01)
        grid_x, grid_y = np.meshgrid(x, y)

        # Coordenadas de estaciones y valores
        points = df_filtered[['Longitud', 'Latitud']].values
        values = df_filtered[varname].values

        # Interpolación
        grid_t = griddata(points, values, (grid_x, grid_y), method='linear')

        # Cargar shapefile
        ruta_shape = 'capas/dest20gw.shp'
        if not os.path.exists(ruta_shape):
            print(f"Shapefile no encontrado: {ruta_shape}")
            continue

        shpmex = gpd.read_file(ruta_shape)

        # Asegurar sistema de coordenadas compatible
        if shpmex.crs != "EPSG:4326":
            shpmex = shpmex.to_crs("EPSG:4326")

        # Crear figura
        plt.figure(figsize=(10, 8))
        ax = plt.gca()

        # Graficar capa del shapefile
        shpmex.plot(ax=ax, edgecolor='black', facecolor='none')

        # Estaciones
        ax.scatter(df_filtered.Longitud, df_filtered.Latitud, color='black', s=20, label='Estaciones')

        # Contorno interpolado
        ss = ax.contourf(grid_x, grid_y, grid_t, cmap='jet', alpha=0.7)

        # Barra de color
        cbar = plt.colorbar(ss, ax=ax)
        cbar.set_label(graf_conf[varname]["label"])

        # Estética del gráfico
        ax.set_title(f"{graf_conf[varname]['title']} - {date}")
        ax.set_xlabel("Longitud")
        ax.set_ylabel("Latitud")
        ax.legend()
        ax.set_xlim(lonmin - 0.05, lonmax + 0.05)
        ax.set_ylim(latmin - 0.05, latmax + 0.05)

        # Guardar imagen
        output_folder = "output_figures"
        os.makedirs(output_folder, exist_ok=True)
        filename = f"{graf_conf[varname]['file_out']}{date}.png"
        plt.savefig(os.path.join(output_folder, filename), dpi=300)
        plt.close()
        print(f"Figura guardada: {filename}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generar gráficos interpolados de estaciones.")
    parser.add_argument("file", help="Archivo CSV con datos")
    parser.add_argument("varname", choices=["Tmax", "Pmax"], help="Variable a graficar (Tmax o Pmax)")
    args = parser.parse_args()

    grafica(args.file, args.varname)
