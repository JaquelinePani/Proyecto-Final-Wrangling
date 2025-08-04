# ----------------------------------------------------------
# Etapa 1: Configuración y adquisión de datos
# ----------------------------------------------------------
#Jaqueline Pani Delgado 

# Instalación de paquetes 
install.packages("readr")
install.packages("readxl")
install.packages("here")
install.packages("dplyr")

# Cargar librerías necesarias
library(readr)
library(readxl)
library(here)
library(dplyr)

# 1. Documentación de la fuente de datos
# Origen: Kaggle
# URL: https://www.kaggle.com/datasets/ihmstefanini/industrial-safety-and-health-analytics-database?select=IHMStefanini_industrial_safety_and_health_database.csv
# Fecha descarga: 15/07/2025
# Método lectura: read_csv, delimitador por comas
#Relevancia: La salud y seguridad industrial son esenciales para proteger la integridad de los trabajadores y
#prevenir accidentes.Contar con un dataset que recopile datos sobre accidentes laborales es fundamental para
#fortalecer la seguridad industrial. Nos permite identificar patrones, causas de accidentes y prevenir riesgos.

datos_originales <- read_csv(here("data", "raw", "datos.csv"))
datos_procesados <- datos_originales %>%
  filter(!is.na(`Accident Level`))
  
# Guardar datos procesados
write_csv(datos_procesados, here("data", "processed", "datos_procesados.csv"))
head(datos_procesados)
glimpse(datos_procesados)
View(datos_procesados)

# 2. Documentación de la fuente de datos
# Origen: Kaggle
# URL: https://www.kaggle.com/datasets/canozensoy/industrial-iot-dataset-synthetic
# Fecha descarga: 25/04/2025
# Método lectura: read_csv, lectura directa desde URL
#Relevancia:Es clave los datos de sensores industriales para optimizar procesos, mejorar el mantenimiento y 
#aumentar la eficiencia operativa. Se puede prevenir y detectar fallas así como anomalias antes de fallos 
#criticos previniendo accidentes.

datos_web <- read_csv("https://docs.google.com/spreadsheets/d/1K6eIbhs2pVl7iKgPcio16UfS8mhA0fXAKsxPFf83QyM/export?format=csv")
View(datos_web)
