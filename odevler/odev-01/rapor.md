# Ödev 1 Raporu

Ad soyad: Artun Toprak Dereli
Öğrenci no: 202607131017
PR bağlantısı: (PR'ı açınca buraya yapıştıracağım)

## Ne yaptım (her bölüm için 1-2 cümle)
- Bölüm 1: Soru 1.1'de kodu çalıştırmadan izleyip total = 14, result = [7, 9, 5, 1] buldum. 1.2'de eşik üstündeki en uzun seriyi bulan bir döngü yazdım (sonuç 5). 1.3'te sözlükle ders sayısını hesapladım.
- Bölüm 2: Excel'in üç sorununu (çakışan veri, aynı anda düzenleme, tutarsızlık) ve veritabanının bunları nasıl çözdüğünü anlattım; birincil anahtar, DBMS ile veritabanı farkı ve eşzamanlı düzenleme sorularını kısa cevapladım.
- Bölüm 3: llm_ops veritabanını Codespaces'te kurup Hafta 4'ün 15 sorusunu çözdüm; her sorgunun altına kaç satır döndüğünü yazdım.
- Bölüm 4: Hafta 5'in 15 sorusunu (sayma, gruplama, HAVING, NULL, CASE) çözdüm ve her sorgunun altına sonucun ne anlama geldiğini yazdım.

## Beklemediğim bir sonuç
WHERE cost_usd = NULL hata vermedi ama 0 satır döndürdü, WHERE cost_usd IS NULL ise faturası gelmemiş 1 çağrıyı buldu. Sorgunun çalışıp yanlış (boş) sonuç vermesi beni şaşırttı; NULL "bilinmiyor" demek olduğu için hiçbir şeye eşit sayılmıyormuş.

## Bir hata ve çözümü
Codespaces'te createdb komutunu çalıştırınca "createdb: command not found" hatası aldım. Nedeni, bu ortamda PostgreSQL'in kurulu olmamasıydı. sudo apt-get install postgresql ile kurup sudo service postgresql start ile servisi başlattım, sonra veritabanını yükledim.

## Yapay zeka beyanı
Hangi araç, hangi soruda, ne sordum, cevabı nasıl doğruladım: claude.ai kullandım.
- Kurulum: GitHub fork'u, GitHub Desktop ve dosya yapısı için adım adım yardım aldım.
- Soru 1.1: Tahmini kendim yaptım, Claude yalnızca kontrol etti.
- Soru 1.2 ve 1.3: Kodları Claude'dan aldım. pythontutor.com'da çalıştırıp çıktıların beklenen sonuçla aynı olduğunu doğruladım (1.2'de 5 çıktı).
- Bölüm 2: Excel sorunlarını Claude'la konuşarak buldum, diğer cevapları örnek taslaktan alıp kendi sözlerimle yeniden yazdım.
- Bölüm 3 ve 4: Sorguları Claude'dan aldım. Sorguları Codespaces'te kendim çalıştırdım, satır sayılarını ve yorumlardaki sayıları psql çıktılarından kontrol ettim.

## Hocaya soru
Bu ödevde aklıma takılan, tekrar anlatılmasını istediğim bir konu kalmadı.

## Hocanın özellikle sorduğu 4 soru
1. Parantez tuzağı (Hafta 4, Soru 7): Parantezli ve parantezsiz sorgu ikisi de 3 satır döndürdü, fark 0 çıktı. Bu veride sadece iki "code" çağrısı var ve ikisi de 0.01 doları aşıyor. Ucuz bir "code" çağrısı olsaydı parantezsiz sorgu onu da getirirdi, çünkü AND, OR'dan önce çalışıyor.
2. Türkçe sıralama (Hafta 4, Soru 14): COLLATE ile ve COLLATE olmadan sıra aynı çıktı (Deniz, Ece, Mert, Oğuz, Selin), hiçbir isim yer değiştirmedi. Bu veride Türkçe karakter içeren tek isim Oğuz ve komşu isimlerle sırası değişmiyor.
3. Kayıp kayıtlar (Hafta 5): cost_usd < 0.01 için 8, cost_usd >= 0.01 için 3 satır geldi. Toplam 11 ediyor, 12 çağrıdan 1'i kayboldu. Kaybolan, faturası gelmemiş 11 numaralı çağrı: cost_usd'si NULL olduğu için iki karşılaştırma da onu geçirmiyor.
4. İki ortalama (Hafta 5): avg(cost_usd) 0.0057, avg(coalesce(cost_usd, 0)) 0.0053 çıktı, fark 0.0004 dolar. Boşu atlayan ortalama daha dürüst, çünkü faturası gelmemiş bir çağrı "ücretsiz" değil, "bilinmiyor". Sıfır saymak maliyeti olduğundan düşük gösterir.