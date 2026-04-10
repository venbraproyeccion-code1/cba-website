# ============================================================
# CBA CRYPTO PAY — ANÁLISIS EN R
# Autor: Alfonso E. Grammatica Rivero
# Certificado: Google Data Analytics — Capstone Project
# Descripción: Análisis estadístico y visualización con ggplot2
# ============================================================

# --- LIBRERÍAS ---
library(tidyverse)
library(ggplot2)
library(lubridate)
library(scales)
library(dplyr)

# --- CARGA DE DATOS ---
crypto_tx <- read.csv("cba_crypto_dataset.csv", stringsAsFactors = FALSE)
security  <- read.csv("cba_security_dataset.csv", stringsAsFactors = FALSE)

# --- EXPLORACIÓN INICIAL ---
glimpse(crypto_tx)
summary(crypto_tx)
colSums(is.na(crypto_tx))

# --- LIMPIEZA ---
crypto_tx <- crypto_tx %>%
  mutate(
    fecha_tx   = as.Date(fecha_tx),
    monto_usdt = as.numeric(monto_usdt),
    roas       = as.numeric(roas),
    blocked_tx = as.integer(blocked_tx)
  ) %>%
  filter(!is.na(monto_usdt), monto_usdt > 0)

# --- KPIs GENERALES ---
kpis <- crypto_tx %>%
  summarise(
    total_tx           = n(),
    volumen_total      = sum(monto_usdt),
    roas_promedio      = mean(roas),
    tasa_exito         = mean(estado == "exitosa") * 100,
    ataques_bloqueados = sum(blocked_tx),
    monto_protegido    = sum(monto_usdt[blocked_tx == 1])
  )
print(kpis)

# --- VISUALIZACIÓN 1: ROAS POR TOKEN ---
crypto_tx %>%
  group_by(token) %>%
  summarise(roas_prom = mean(roas), n_tx = n()) %>%
  ggplot(aes(x = reorder(token, roas_prom), y = roas_prom, fill = token)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  scale_fill_manual(values = c("#00C9A7","#D4A853","#FF6B5A","#8A4FFF","#00A389")) +
  labs(
    title    = "ROAS Promedio por Token — CBA Crypto Pay",
    subtitle = "Proyecto Capstone | Google Data Analytics",
    x        = "Token",
    y        = "ROAS Promedio",
    caption  = "Fuente: cba_crypto_dataset.csv"
  ) +
  theme_minimal(base_size = 13)

# --- VISUALIZACIÓN 2: TENDENCIA MENSUAL DE VOLUMEN ---
crypto_tx %>%
  mutate(mes = floor_date(fecha_tx, "month")) %>%
  group_by(mes) %>%
  summarise(volumen = sum(monto_usdt)) %>%
  ggplot(aes(x = mes, y = volumen)) +
  geom_line(color = "#00C9A7", size = 1.2) +
  geom_point(color = "#D4A853", size = 3) +
  scale_y_continuous(labels = dollar_format(prefix = "$")) +
  labs(
    title    = "Tendencia Mensual de Volumen — CBA Crypto Pay",
    x        = "Mes",
    y        = "Volumen (USDT)",
    caption  = "Fuente: cba_crypto_dataset.csv"
  ) +
  theme_minimal(base_size = 13)

# --- VISUALIZACIÓN 3: ATAQUES POR TIPO DE AMENAZA ---
security %>%
  count(threat_type, sort = TRUE) %>%
  ggplot(aes(x = reorder(threat_type, n), y = n, fill = threat_type)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title    = "Ataques Bloqueados por Tipo de Amenaza",
    x        = "Tipo de Amenaza",
    y        = "Cantidad de Intentos",
    caption  = "Fuente: cba_security_dataset.csv"
  ) +
  theme_minimal(base_size = 13)

# --- VISUALIZACIÓN 4: ROAS POR BIOMETRÍA ---
crypto_tx %>%
  group_by(biometria) %>%
  summarise(roas_prom = mean(roas), n = n()) %>%
  ggplot(aes(x = biometria, y = roas_prom, fill = biometria)) +
  geom_col(show.legend = FALSE, width = 0.5) +
  scale_fill_manual(values = c("#00C9A7", "#D4A853")) +
  labs(
    title = "ROAS Promedio según Autenticación Biométrica",
    x     = "Biometría",
    y     = "ROAS Promedio"
  ) +
  theme_minimal(base_size = 13)

# --- EXPORTAR RESUMEN ---
write.csv(kpis, "kpis_resumen.csv", row.names = FALSE)
cat("✅ Análisis completado. KPIs exportados a kpis_resumen.csv\n")
