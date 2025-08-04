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
datos_originales <- read_csv(here("data", "raw", "datos.csv"))

#Auditoria de datos
head(datos_originales)
str(datos_originales)

#Normalizar los datos 
datos_originales <- datos_originales %>% clean_names()
colnames(datos_originales)

datos_procesados <- datos_originales

datos_procesados <- datos_procesados %>%
  filter(risco_critico != "Others")

datos_procesados <- datos_procesados %>%
  mutate(
    data = trimws(data),  # Quita espacios invisibles
    data = dmy_hm(data),  # Convierte a fecha con hora
  )

datos_procesados <- datos_procesados %>%
  mutate(data = format(as.Date(data), "%Y"))

datos_procesados$accident_level <- as.numeric(as.roman(datos_procesados$accident_level))
datos_procesados$potential_accident_level <- as.numeric(as.roman(datos_procesados$potential_accident_level))

# Guardar datos procesados
write_csv(datos_procesados, here("data", "processed", "datos_procesados.csv"))
head(datos_procesados)
glimpse(datos_procesados)
View(datos_procesados)