# ----------------------------------------------------------
# Etapa 2: Limpieza y estandarización
# ----------------------------------------------------------
#Jaqueline Pani Delgado 

# Instalación de paquetes 
install.packages("readr")
install.packages("readxl")
install.packages("here")
install.packages("dplyr")
install.packages("janitor")

# Cargar librerías necesarias
library(readr)
library(readxl)
library(here)
library(janitor)
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)

#Cargar el dataset
datos_web <- read_csv("https://docs.google.com/spreadsheets/d/1K6eIbhs2pVl7iKgPcio16UfS8mhA0fXAKsxPFf83QyM/export?format=csv")
View(datos_web)
#Auditoria de datos
head(datos_web)
str(datos_web)

#Normalizar los datos 
datos_web <- datos_web %>% clean_names()
colnames(datos_web)

datos_procesados_web <- datos_web

#Filtrar datos: Máquinas CNC instaladas en el año 2016
datos_procesados_web <- datos_procesados_web[datos_procesados_web$machine_type %in% c("CNC_Lathe"), ]
datos_procesados_web <- datos_procesados_web %>%
  filter(installation_year %in% c(2016, 2017))

datos_procesados_web <- datos_procesados_web %>%
  filter(failure_history_count != "0")

# Guardar datos procesados
write_csv(datos_procesados_web, here("data", "processed", "datos_procesados_web.csv"))
head(datos_procesados_web)
glimpse(datos_procesados_web)
View(datos_procesados_web)