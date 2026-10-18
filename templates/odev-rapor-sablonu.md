# Ödev Raporu

---

**Ödev no:** Ödev 1     **Hafta:** 1-5     **Tarih:** 23 / 10 / 2026

**Ad Soyad:** Artun Toprak Dereli  **Öğrenci No:** 202607131017

**Program:** ☒ Yapay Zeka Operatörlüğü  ☐ Robotik ve Yapay Zeka

**Kullandığım veritabanı:** ☒ `llm_ops`  ☐ `robot_fleet`

**PR bağlantısı:** `https://github.com/artuntprk/blp105-course/pull/1`

**Commit sayısı:** 9

---

## 1. Ne yaptım

İlk beş haftanın konularını tek ödevde uyguladım. Python'da bir kodu önce kafamdan izleyip tahmin ettim, döngüyle en uzun seriyi buldum ve sözlükle elle gruplama yaptım. Veritabanı kavramlarını (Excel'in sorunları, birincil anahtar, DBMS, aynı anda düzenleme) kendi sözlerimle yazdım. llm_ops veritabanında SELECT/WHERE ve GROUP BY/HAVING/NULL sorularını çözdüm. En çok, NULL'ın sonucu sessizce değiştirdiğini öğrendim.

---

## 2. Sonuçlar

Çözdüğüm soru sayısı: 37 / 37     Bonus: ☐ denedim ☒ denemedim

En zorlandığım soru: **Soru 14 (Hafta 4)**

Neden zorlandım:

Türkçe sıralama için COLLATE kullanınca "for SELECT DISTINCT, ORDER BY expressions must appear in select list" hatası aldım.

Nasıl çözdüm:

DISTINCT'i bir alt sorguya aldım, COLLATE'li sıralamayı dışarıdaki sorguda yaptım.

---

## 3. Beklemediğim bir sonuç

**Soru no:** Hafta 5, Soru 12

**Beklediğim:** 1 satır   **Gelen:** 0 satır

**Sebebi:**

WHERE cost_usd = NULL hata vermedi ama hiç satır getirmedi. NULL "bilinmiyor" demek olduğu için hiçbir şeye eşit sayılmıyor. IS NULL ile faturası gelmemiş 1 çağrıyı buldum.

---

## 4. Aldığım bir hata ve çözümü

**Hata mesajı:**

bash: createdb: command not found

**Sebebi ve çözümü:**

Codespaces'te PostgreSQL kurulu değildi. sudo apt-get install postgresql ile kurdum, sudo service postgresql start ile başlattım, sonra veritabanını yükledim.

---

## 5. Yapay zeka kullanım beyanı

☐ Bu ödevde yapay zeka aracı **kullanmadım.**

☒ Kullandım, aşağıda belirttim:

| Soru no | Araç | Ne sordum (özet) | Cevabı nasıl doğruladım |
|---|---|---|---|
| Kurulum | Claude (claude.ai) | GitHub fork, GitHub Desktop, dosya yapısı; boş iskelet dosyalarını Claude hazırladı | Adımları uygulayıp dosyaları GitHub'da gördüm |
| 1.1 | Claude | Tahmini kendim yaptım, Claude yalnızca kontrol etti | Claude'un kontrolüyle karşılaştırdım (total = 14, result = [7, 9, 5, 1]) |
| 1.2, 1.3 | Claude | Kod ve sözde kod | Kodu çalıştırıp çıktıyı kontrol ettim (1.2'de 5, 1.3'te beklenen sözlük) |
| Bölüm 2 | Claude | Excel sorunlarını konuşarak buldum, taslak aldım | Kendi sözlerimle yeniden yazdım |
| Bölüm 3, 4 | Claude | SQL sorguları ve yorum taslakları | Codespaces'te kendim çalıştırdım, satır sayılarını psql çıktısıyla karşılaştırdım |

---

## 6. Öz değerlendirme

| Ölçüt | 4 Tam | 3 İyi | 2 Gelişmeli | 1 Yetersiz |
|---|---|---|---|---|
| A, Doğruluk | ☐ | ☒ | ☐ | ☐ |
| B, SQL kalitesi | ☐ | ☒ | ☐ | ☐ |
| C, Yorum ve analiz | ☐ | ☒ | ☐ | ☐ |
| D, Git ve PR disiplini | ☐ | ☒ | ☐ | ☐ |
| E, Dürüstlük ve beyan | ☒ | ☐ | ☐ | ☐ |

Bir dahaki ödevde daha iyi yapacağım şey:

Sorguları kendim yazıp denemek ve yorumları kendi cümlelerimle yazmak.

---

## 7. Bana sorun

Bu ödevde tekrar anlatılmasını istediğim bir konu kalmadı.

---

**İmza:** ________________________

---

*Doğruluk beyanı: Bu çalışmayı kendim yaptım. Kullandığım tüm yardımcı kaynakları ve yapay zeka araçlarını yukarıda beyan ettim.*