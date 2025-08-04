# ----------------------------------------------------------
# Etapa 3:Transformación, remodelación y unión de datos
# ----------------------------------------------------------
#Jaqueline Pani Delgado 

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
datos_procesados <- read_csv(here("data", "processed", "datos_procesados.csv"))
datos_procesados_web <- read_csv(here("data", "processed", "datos_procesados_web.csv"))

#Variables
accidentes <- datos_procesados
maquinas <- datos_procesados_web

# Transformación dataset de accidentes
accidentes_limpio <- accidentes %>%
  mutate(
    anio = as.integer(data),
    is_third_party = case_when(
      grepl("Third Party", employee_ou_terceiro, ignore.case = TRUE) ~ TRUE,
      TRUE ~ FALSE
    ),
    severidad_accidente = case_when(
      accident_level >= 4 ~ "Alta",
      accident_level == 3 ~ "Media",
      accident_level <= 2 ~ "Baja"
    ),
    riesgo_general = case_when(
      grepl("Fall|Pressure|Manual|Pressed", risco_critico, ignore.case = TRUE) ~ "Crítico",
      TRUE ~ "No Crítico"
    )
  ) %>%
  select(anio, countries, local, industry_sector, accident_level,
         potential_accident_level, genre, is_third_party, severidad_accidente, riesgo_general)

# Transformación dataset de accidentes de máquinas
maquinas_limpio <- maquinas %>%
  rename(anio = installation_year) %>%
  mutate(
    condiciones_criticas = case_when(
      temperature_c > 60 | vibration_mms > 20 | sound_d_b > 80 ~ TRUE,
      TRUE ~ FALSE
    ),
    eficiencia_baja = case_when(
      power_consumption_k_w > 200 & remaining_useful_life_days < 100 ~ TRUE,
      TRUE ~ FALSE
    )
  ) %>%
  group_by(anio) %>%
  summarise(
    maquinas_criticas = sum(condiciones_criticas, na.rm = TRUE),
    maquinas_baja_eficiencia = sum(eficiencia_baja, na.rm = TRUE),
    total_maquinas = n(),
    promedio_temp = mean(temperature_c, na.rm = TRUE),
    promedio_sonido = mean(sound_d_b, na.rm = TRUE)
  )

# Unificación de data set (por años)
final_dataset <- accidentes_limpio %>%
  group_by(anio) %>%
  summarise(
    total_accidentes = n(),
    accidentes_criticos = sum(riesgo_general == "Crítico", na.rm = TRUE),
    porcentaje_terceros = mean(is_third_party),
    porcentaje_alta_severidad = mean(severidad_accidente == "Alta")
  ) %>%
  left_join(maquinas_limpio, by = "anio")

# Guardar datos procesados
write_csv(final_dataset, here("data", "processed", "final_dataset.csv"))
head(final_dataset)
glimpse(final_dataset)
View(final_dataset)
