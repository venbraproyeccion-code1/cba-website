-- ============================================================
-- CBA CRYPTO PAY — CAPSTONE GOOGLE DATA ANALYTICS
-- Autor: Alfonso E. Grammatica Rivero
-- Proyecto: Análisis de transacciones cripto para turismo
-- Dataset: cba.crypto_tx | 1,247 transacciones | $2.3M volumen
-- ============================================================

-- 1. KPIs GENERALES
SELECT 
  COUNT(*)                          AS total_transacciones,
  ROUND(SUM(monto_usdt), 2)         AS volumen_total_usd,
  ROUND(AVG(roas), 4)               AS roas_promedio,
  ROUND(100.0 * SUM(CASE WHEN estado = 'exitosa' THEN 1 ELSE 0 END) / COUNT(*), 2) AS tasa_exito_pct,
  SUM(blocked_tx)                   AS ataques_bloqueados,
  ROUND(SUM(CASE WHEN blocked_tx = 1 THEN monto_usdt ELSE 0 END), 2) AS monto_protegido_usd
FROM `cba.crypto_tx`;

-- 2. EFECTIVIDAD DE SEGURIDAD POR TIPO DE AMENAZA
SELECT 
  threat_type,
  COUNT(*)                          AS intentos,
  ROUND(AVG(risk_score), 2)         AS severidad_promedio,
  ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM `cba.crypto_tx`), 2) AS porcentaje_del_total
FROM `cba.crypto_tx` 
WHERE blocked_tx = 1
GROUP BY threat_type 
ORDER BY intentos DESC;

-- 3. ROAS POR TOKEN Y MÉTODO DE AUTENTICACIÓN (BIOMETRÍA)
SELECT 
  token,
  biometria,
  ROUND(AVG(roas), 4)               AS roas_promedio,
  COUNT(*)                          AS num_transacciones,
  ROUND(SUM(monto_usdt), 2)         AS revenue_usd
FROM `cba.crypto_tx`
GROUP BY token, biometria
ORDER BY roas_promedio DESC;

-- 4. TENDENCIA MENSUAL DE TRANSACCIONES Y VOLUMEN
SELECT
  FORMAT_DATE('%Y-%m', fecha_tx)    AS mes,
  COUNT(*)                          AS total_tx,
  ROUND(SUM(monto_usdt), 2)         AS volumen_usd,
  ROUND(AVG(roas), 4)               AS roas_mes
FROM `cba.crypto_tx`
GROUP BY mes
ORDER BY mes ASC;

-- 5. TOP 5 TOKENS POR VOLUMEN
SELECT
  token,
  COUNT(*)                          AS transacciones,
  ROUND(SUM(monto_usdt), 2)         AS volumen_usd,
  ROUND(AVG(roas), 4)               AS roas_promedio
FROM `cba.crypto_tx`
GROUP BY token
ORDER BY volumen_usd DESC
LIMIT 5;

-- 6. ANÁLISIS DE RIESGO — TRANSACCIONES DE ALTO RIESGO NO BLOQUEADAS
SELECT
  tx_id,
  token,
  monto_usdt,
  risk_score,
  threat_type,
  biometria,
  fecha_tx
FROM `cba.crypto_tx`
WHERE risk_score > 0.75 AND blocked_tx = 0
ORDER BY risk_score DESC;
