# CBA Crypto Pay — Google Data Analytics Capstone

**Autor:** Alfonso E. Grammatica Rivero  
**Certificado:** Google Data Analytics Professional Certificate  
**Fecha:** Abril 2026  

---

## Resumen Ejecutivo

Plataforma de pagos cripto para CBA (Container Beach Adventures) — empresa de turismo receptivo en Venezuela. Se procesaron **1,247 transacciones** con un volumen total de **$2.3M USDT**, logrando una tasa de éxito del **97.8%** y bloqueando **187 ataques** que protegieron **$47K** en fondos.

---

## Herramientas Utilizadas

| Herramienta | Uso |
|---|---|
| ✅ Google Sheets / Excel | Limpieza y exploración inicial de datos |
| ✅ SQL / BigQuery | Consultas KPI, JOINs, análisis de seguridad |
| ✅ R / RStudio | Análisis estadístico y visualizaciones ggplot2 |
| ✅ Tableau | Dashboard interactivo de métricas y seguridad |

---

## Las 6 Fases del Análisis (Ask → Act)

### 1. ASK — Preguntar
- ¿Cuál es la tasa de éxito de las transacciones?
- ¿Qué tokens generan mejor ROAS?
- ¿La autenticación biométrica mejora el rendimiento?
- ¿Qué tipos de amenazas son más frecuentes?

### 2. PREPARE — Preparar
- Dataset principal: `cba_crypto_dataset.csv` (1,247 filas)
- Dataset seguridad: `cba_security_dataset.csv`
- Variables clave: token, monto_usdt, roas, biometria, blocked_tx, threat_type, risk_score

### 3. PROCESS — Procesar
- Limpieza en R: eliminación de nulos, conversión de tipos
- Validación de rangos (monto > 0, risk_score entre 0 y 1)
- Estandarización de fechas con lubridate

### 4. ANALYZE — Analizar
- ROAS promedio: **1.15x**
- Token con mejor ROAS: **ETH**
- Transacciones con biometría activa: **+23% ROAS** vs sin biometría
- Amenaza más frecuente: **phishing** (42% de ataques)

### 5. SHARE — Compartir
- Dashboard Tableau con 4 vistas: KPIs, tendencia, seguridad, tokens
- Visualizaciones R exportadas en PNG
- Reporte ejecutivo en Markdown

### 6. ACT — Actuar
- Implementar biometría obligatoria en todas las transacciones
- Reforzar filtros anti-phishing
- Priorizar ETH y USDT como tokens principales
- Revisar transacciones de alto riesgo no bloqueadas (risk_score > 0.75)

---

## Métricas Clave

| Métrica | Valor |
|---|---|
| 📊 Total transacciones | 1,247 |
| 💰 Volumen total | $2,300,000 USDT |
| ✅ Tasa de éxito | 97.8% |
| 📈 ROAS promedio | 1.15x |
| 🔒 Ataques bloqueados | 187 |
| 🛡️ Fondos protegidos | $47,000 USDT |

---

## Estructura del Proyecto

```
GOOGLE-DATA-ANALYTICS/
├── cba_crypto_dataset.csv      ← Dataset principal
├── cba_security_dataset.csv    ← Dataset seguridad
├── cba_analysis.R              ← Análisis R + ggplot2
├── cba_queries.sql             ← Consultas SQL / BigQuery
└── capstone_report.md          ← Este documento
```

---

*Proyecto desarrollado como parte del Google Data Analytics Professional Certificate — Coursera 2026*
