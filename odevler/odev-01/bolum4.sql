-- Ödev 1 - Bölüm 4: Gruplama ve NULL (Hafta 5, llm_ops)

-- Soru 1: Kaç çağrı kaydedilmiş?
SELECT count(*) AS cagri_sayisi
FROM llm_calls;
-- 1 satır döndü (değer: 12).
-- Yorum: Tabloda 12 çağrı var; sonraki sayıları bu toplamla karşılaştırıp kontrol edeceğim.

-- Soru 2: Kaç çağrı 2 saniyeden yavaş?
SELECT count(*) AS yavas_cagri
FROM llm_calls
WHERE latency_ms > 2000;
-- 1 satır döndü (değer: 5).
-- Yorum: Çağrıların 5'i, yani 12'de 5'i (yaklaşık %42) 2 saniyeyi aşıyor; Hafta 4'teki satır sayısıyla aynı çıktı.

-- Soru 3: Toplam maliyet ve toplam token sayısı
SELECT sum(cost_usd) AS toplam_maliyet,
       sum(prompt_tokens + completion_tokens) AS toplam_token
FROM llm_calls;
-- 1 satır döndü (0.0631 dolar, 14340 token).
-- Yorum: sum() NULL'ları atlar; 11 numaralı çağrının faturası gelmediği için gerçek maliyet 0.0631 dolardan yüksektir.

-- Soru 4: Ortalama gecikme (bir ondalık basamak)
SELECT round(avg(latency_ms), 1) AS ort_gecikme
FROM llm_calls;
-- 1 satır döndü (değer: 1848.3).
-- Yorum: Ortalama çağrı yaklaşık 1,8 saniye sürüyor; latency_ms sütununda hiç boş değer olmadığı için bu ortalama 12 çağrının hepsini kapsıyor.

-- Soru 5: En hızlı ve en yavaş çağrı
SELECT min(latency_ms) AS en_hizli,
       max(latency_ms) AS en_yavas
FROM llm_calls;
-- 1 satır döndü (380 ms ve 4100 ms).
-- Yorum: En yavaş çağrı en hızlının yaklaşık 11 katı sürmüş, yani gecikmeler birbirinden çok farklı.

-- Soru 6: Her iş türünde kaç çağrı var?
SELECT task_type,
       count(*) AS cagri
FROM llm_calls
GROUP BY task_type;
-- 5 satır döndü.
-- Yorum: 5 satır çıktı çünkü veride 5 farklı iş türü var (summarize 3, chat 3, code 2, translate 2, classify 2); sayılar toplanınca 12 ediyor.

-- Soru 7: Her model için çağrı sayısı ve toplam maliyet, pahalıdan ucuza
SELECT model_name,
       count(*) AS cagri,
       sum(cost_usd) AS toplam_maliyet
FROM llm_calls
GROUP BY model_name
ORDER BY toplam_maliyet DESC NULLS LAST;
-- 7 satır döndü.
-- Yorum: claude-sonnet sadece 2 çağrıyla 0.0384 dolarla en pahalı model; gpt-4o'nun 3 çağrısından biri (11 numara) faturasız olduğu için onun toplamı 0.0179 olarak eksik görünüyor.

-- Soru 8: Her kullanıcının her iş türünden kaç çağrısı var?
SELECT user_name,
       task_type,
       count(*) AS cagri
FROM llm_calls
GROUP BY user_name, task_type
ORDER BY user_name, task_type;
-- 12 satır döndü.
-- Yorum: Beklemediğim satır, user_name'i boş olan chat çağrısı; GROUP BY NULL'ları kendi grubu yapıyor, yani anonim betiğin çağrısı kayıp gitmedi ama adı olmayan bir satır olarak çıktı.

-- Soru 9: İkiden fazla çağrı almış modeller
SELECT model_name,
       count(*) AS cagri
FROM llm_calls
GROUP BY model_name
HAVING count(*) > 2;
-- 1 satır döndü.
-- Yorum: "İkiden fazla" 2'den büyük, yani 3 ve üstü demek; sadece gpt-4o (3 çağrı) bu eşiği geçiyor, 2 çağrılı modeller listeye girmiyor.

-- Soru 10: 500 ms'den yavaş çağrılar içinde en az 2 çağrısı olan modeller, ortalama gecikmeyle
SELECT model_name,
       count(*) AS cagri,
       round(avg(latency_ms), 1) AS ort_gecikme
FROM llm_calls
WHERE latency_ms > 500
GROUP BY model_name
HAVING count(*) >= 2;
-- 3 satır döndü.
-- Yorum: WHERE önce 380 ve 450 ms'lik iki hızlı çağrıyı eledi (gruplamadan önce), HAVING ise bu eleme sonrası tek çağrısı kalan modelleri eledi (ör. llama-3-8b, 2 çağrısı varken 1'e düştü); geriye claude-sonnet, gpt-4o ve claude-haiku kaldı.

-- Soru 11: llm_calls tablosunda hangi sütunda kaç eksik veri var?
SELECT count(*) AS satir,
       count(id) AS id_dolu,
       count(model_name) AS model_dolu,
       count(user_name) AS user_dolu,
       count(task_type) AS task_dolu,
       count(prompt_tokens) AS prompt_dolu,
       count(completion_tokens) AS completion_dolu,
       count(latency_ms) AS latency_dolu,
       count(cost_usd) AS cost_dolu,
       count(created_at) AS tarih_dolu
FROM llm_calls;
-- 1 satır döndü.
-- Sütun        | Dolu | Eksik
-- user_name    | 11   | 1
-- cost_usd     | 11   | 1
-- diğer 7 sütun| 12   | 0
-- Yorum: Sadece iki sütunda eksik var: user_name (anonim betik çağrısı) ve cost_usd (faturası gelmemiş 11 numaralı çağrı); count(*) 12 sayarken count(sütun) NULL'ları saymadığı için fark ortaya çıkıyor.

-- Soru 12: Faturası gelmemiş çağrılar (önce = NULL ile, sonra IS NULL ile)
SELECT *
FROM llm_calls
WHERE cost_usd = NULL;
-- 0 satır döndü.

SELECT *
FROM llm_calls
WHERE cost_usd IS NULL;
-- 1 satır döndü (11 numaralı çağrı).
-- Yorum: = NULL hiçbir satır getirmedi çünkü NULL "bilinmiyor" demek ve bilinmeyen bir şey hiçbir şeye eşit sayılmaz; doğru yöntem IS NULL ve faturasız çağrıyı bulur.

-- Soru 13: İki ortalama (boşu atlayarak ve boşu sıfır sayarak)
SELECT round(avg(cost_usd), 4) AS atlayarak,
       round(avg(coalesce(cost_usd, 0)), 4) AS sifir_sayarak
FROM llm_calls;
-- 1 satır döndü (0.0057 ve 0.0053).
-- Yorum: Aralarındaki fark 0.0004 dolar (yaklaşık %7); avg() boşu atlayıp 11 çağrıyı bölerken COALESCE ile 12'ye bölünüyor. Bu veri için atlayarak hesaplamak daha dürüst, çünkü faturası gelmemiş bir çağrı "ücretsiz" değil "bilinmiyor"; sıfır saymak maliyeti olduğundan düşük gösterir.

-- Soru 14: Günlük kullanım raporu (gün, çağrı sayısı, toplam maliyet)
SELECT created_at::date AS gun,
       count(*) AS cagri,
       sum(cost_usd) AS toplam_maliyet
FROM llm_calls
GROUP BY gun
ORDER BY gun;
-- 6 satır döndü.
-- Yorum: En çok çağrı alan gün 16 Ekim (5 çağrı), ama toplam maliyeti sadece 0.0053 dolar; çünkü o günün çağrıları ucuz modellere gitmiş ve gpt-4o çağrısının (11 numara) faturası boş olduğu için toplama girmemiş.

-- Soru 15: Gecikmeye göre kategori (Hızlı / Orta / Yavaş), çağrı sayısı ve ortalama gecikme
SELECT CASE
           WHEN latency_ms < 1000 THEN 'Hızlı'
           WHEN latency_ms < 2500 THEN 'Orta'
           ELSE 'Yavaş'
       END AS kategori,
       count(*) AS cagri,
       round(avg(latency_ms), 1) AS ort_gecikme
FROM llm_calls
GROUP BY kategori
ORDER BY ort_gecikme;
-- 3 satır döndü.
-- Yorum: 12 çağrı üç kategoriye 4'er olarak eşit bölünüyor; Hızlı grubun ortalaması 607.5 ms, Yavaş grubunki 3162.5 ms, yani en yavaş grup en hızlının yaklaşık 5 katı.