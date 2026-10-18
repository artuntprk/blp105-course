-- Ödev 1 - Bölüm 3: SELECT ve WHERE (Hafta 4, llm_ops)

-- Soru 1: Bütün çağrıların id'si ve model adı
SELECT id, model_name
FROM llm_calls;
-- 12 satır döndü.

-- Soru 2: Model adı ve toplam token sayısı (prompt + completion)
SELECT model_name AS model,
       prompt_tokens + completion_tokens AS total_tokens
FROM llm_calls;
-- 12 satır döndü.

-- Soru 3: Gecikmesi 2 saniyeyi aşan çağrılar (sütun ms, yani 2000)
SELECT *
FROM llm_calls
WHERE latency_ms > 2000;
-- 5 satır döndü.

-- Soru 4: Ece'nin yaptığı çağrılar
SELECT *
FROM llm_calls
WHERE user_name = 'Ece';
-- 3 satır döndü.

-- Soru 5: Sohbet (chat) dışındaki çağrılar
SELECT *
FROM llm_calls
WHERE task_type <> 'chat';
-- 9 satır döndü.

-- Soru 6: claude ile başlayan modellere yapılan, 1 saniyeden yavaş çağrılar
SELECT *
FROM llm_calls
WHERE model_name LIKE 'claude%'
  AND latency_ms > 1000;
-- 2 satır döndü.

-- Soru 7: Kod veya çeviri işi olan, maliyeti 0.01 doları aşan çağrılar
SELECT *
FROM llm_calls
WHERE (task_type = 'code' OR task_type = 'translate')
  AND cost_usd > 0.01;
-- 3 satır döndü.

-- Soru 7 (parantezsiz, tuzak denemesi)
SELECT *
FROM llm_calls
WHERE task_type = 'code' OR task_type = 'translate'
  AND cost_usd > 0.01;
-- 3 satır döndü. Parantezliyle fark: 0 satır.

-- Soru 8: Gecikmesi 500 ile 1500 ms arasındaki çağrılar (uçlar dahil)
SELECT *
FROM llm_calls
WHERE latency_ms BETWEEN 500 AND 1500;
-- 3 satır döndü.

-- Soru 9: gpt ailesine yapılan çağrılar
SELECT *
FROM llm_calls
WHERE model_name IN ('gpt-4o', 'gpt-4o-mini');
-- 4 satır döndü.

-- Soru 10: Model adında "mini" geçen çağrılar
SELECT *
FROM llm_calls
WHERE model_name ILIKE '%mini%';
-- 3 satır döndü.

-- Soru 11: Önce kullanıcıya, kullanıcı içinde maliyete (pahalıdan ucuza) göre sırala
SELECT *
FROM llm_calls
ORDER BY user_name, cost_usd DESC NULLS LAST;
-- 12 satır döndü.

-- Soru 12: En pahalı 3 çağrı
SELECT *
FROM llm_calls
ORDER BY cost_usd DESC NULLS LAST
LIMIT 3;
-- 3 satır döndü.

-- Soru 13: Hangi iş türleri (task_type) var?
SELECT DISTINCT task_type
FROM llm_calls;
-- 5 satır döndü.

-- Soru 14: Kullanıcı adları, tekrarsız (COLLATE olmadan)
SELECT DISTINCT user_name
FROM llm_calls
ORDER BY user_name;
-- 6 satır döndü (biri NULL).

-- Soru 14 (Türkçe alfabe sırasıyla, COLLATE ile)
SELECT user_name
FROM (SELECT DISTINCT user_name FROM llm_calls) AS t
ORDER BY user_name COLLATE "tr-TR-x-icu";
-- 6 satır döndü. Yer değiştiren isimler: Hiçbir isim yer değiştirmedi.

-- Soru 15: 14 Ekim'den sonra yapılan, 1 saniyeden yavaş çağrıların id'si, modeli ve gecikmesi, en yavaştan başla
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE created_at > '2026-10-14'
  AND latency_ms > 1000
ORDER BY latency_ms DESC;
-- 6 satır döndü.