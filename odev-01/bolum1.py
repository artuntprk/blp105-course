# Ödev 1 - Bölüm 1: Algoritma ve izleme

# --- Soru 1.1: İz sürme ---
# Önce kâğıtta tabloyu doldur, sonra kodu çalıştır.
numbers = [4, 7, 2, 9, 5, 1, 8]
total = 0
result = []

for i in range(len(numbers)):
    if numbers[i] % 2 == 0:
        total = total + numbers[i]
    else:
        result.append(numbers[i])

print(total)
print(result)
# Tahminim: total = 14, result = [7, 9, 5, 1]
# Tahminim tuttu mu? Tutmadıysa hangi adımda yanıldım:Tahminim doğru


# --- Soru 1.2: En uzun seri ---
readings = [18, 21, 23, 25, 24, 26, 27, 19, 20, 22, 23, 24, 25, 26]
threshold = 22

# Sözde kod:
# en_uzun = 0, simdiki = 0
# listedeki her değer için:
#     değer eşikten büyükse:
#         simdiki bir artar
#         simdiki en_uzun'dan büyükse en_uzun = simdiki
#     değilse:
#         simdiki = 0   (seri koptu)
# en_uzun'u yazdır


# Python:
en_uzun = 0
simdiki = 0

for value in readings:
    if value > threshold:
        simdiki = simdiki + 1
        if simdiki > en_uzun:
            en_uzun = simdiki
    else:
        simdiki = 0

print(en_uzun)

# --- Soru 1.3: Elle gruplama ---
records = [
    {"student": "Ece", "course": "VTYS"},
    {"student": "Ali", "course": "Yapay Zeka"},
    {"student": "Ece", "course": "Yapay Zeka"},
    {"student": "Can", "course": "VTYS"},
    {"student": "Ali", "course": "VTYS"},
    {"student": "Ece", "course": "Robotik"},
]
# Sadece for, if ve sözlük. Counter ve groupby yasak.
# Beklenen çıktı: {"VTYS": 3, "Yapay Zeka": 2, "Robotik": 1}

