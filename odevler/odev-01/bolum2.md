# Ödev 1 - Bölüm 2: Veritabanı kavramları

## 1. Excel dosyalarında üç somut sorun ve veritabanının çözümü
Excel hatalı veriyi kabul eder numaralar çakışabilir : Veritabanı ise kurala uymayan kaydı kabul etmez hata verir.

İki kişi aynı dosyayı aynı anda düzenlerse en son kaydedenin işlemi gerçekleşir : Veritabanı ise işlem sırayla yapıldığı için  birbirinin üstüne yazamaz

Aynı bilgi birden fazla dosyada olursa biri güncellenip diğeri güncellenmezse farklı sayılar kalır, hangisinin doğru olduğu belli olmaz : Veritabanı ise bilgiyi tek yerde tuttuğu için bir kere değişince her yerde doğru görünür.


## 2. Birincil anahtar
Birincil anahtar tablodaki her kişiyi ayırt etmemizi sağlar. Mesela öğrenci numarası herkesin farklı olduğu için iyi bir örnektir. Ama ad soyad olmaz çünkü aynı isimde iki kişi olabilir veya isim yanlış yazılabilir.


## 3. DBMS ile veritabanı farkı
Veritabanı bilgilerin düzenli şekilde tutulduğu yerdir. DBMS ise bu bilgileri yönetmeye yarayan programdır. PostgreSQL de buna bir örnektir.

## 4. Aynı anda iki kişi aynı kaydı değiştirirse
Veritabanında işlemler sırayla yapılır veya kilitlenir. Böylece birinin yaptığı değişiklik diğerinin yaptığı değişikliği yanlışlıkla silmez.
