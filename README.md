# 🃏 UNI — Praktikum / Tugas Besar

> Implementasi permainan kartu UNO dalam bahasa pemrograman **Prolog** dengan berbagai fitur tambahan seperti tantangan Wild Draw Four, seruan UNI, penyembunyian kartu, dan kejadian acak God's Hand.

---

## Cara Menjalankan Program

### Prasyarat
- [GNU-Prolog](http://gprolog.org/#download) terinstal di sistem Anda.

### Langkah-langkah

1. Clone atau unduh repository ini.
2. Buka terminal dan navigasikan ke direktori proyek.
3. Jalankan GNU-Prolog:
   ```bash
   [main.pl] atau consult dan pilih main.pl
   ```
4. Setelah program terbuka, ketik perintah berikut untuk memulai:
   ```prolog
   ?- start.
   ```

---

## 📁 Struktur Repository

```
UNI/
├── main.pl               # Entry point utama, menu awal, dan inisialisasi
├── startgame.pl          # Inisialisasi permainan, deklarasi fakta dinamis
├── kartu.pl              # Definisi kartu dan eksekusi efek kartu spesial
├── distribusiKartu.pl    # Pembuatan deck, pengacakan, dan distribusi kartu
├── pemain.pl             # Input dan validasi nama pemain
├── lihatKartu.pl         # Menampilkan kartu di tangan pemain aktif
├── lihatCommand.pl       # Menampilkan daftar perintah yang tersedia
├── mainkanKartu.pl       # Logika memainkan kartu + pergantian giliran
├── ambilKartu.pl         # Logika mengambil kartu dari deck
├── uni.pl                # Mekanisme seruan UNI (kartu tersisa 2 → 1)
├── tangkap.pl            # Menangkap pemain yang lupa menyerukan UNI
├── tantang.pl            # Tantangan Wild Draw Four
├── sembunyikanKartu.pl   # Fitur menyembunyikan/menampilkan kartu
├── godsHand.pl           # Kejadian acak pemindahan kartu antar pemain
├── cekInfo.pl            # Menampilkan status meja dan jumlah kartu pemain
├── endGame.pl            # Kalkulasi poin akhir dan penentuan pemenang
├── saveGame.pl           # Menyimpan status permainan ke file
└── loadGame.pl           # Memuat kembali status permainan dari file
```

---

## Fitur Utama

| Fitur | Deskripsi |
|---|---|
| **Permainan Multi-Pemain** | Mendukung 2–4 pemain dengan nama unik berawalan huruf kapital |
| **Deck Standar UNO** | 108 kartu (angka 0–9, Skip, Reverse, Draw Two, Wild, Wild Draw Four) diacak setiap sesi |
| **Kartu Spesial** | Efek Skip, Reverse, Draw Two, Wild, dan Wild Draw Four berjalan otomatis |
| **Seruan UNI** | Wajib gunakan `uni(NomorUrut).` saat kartu tersisa 2; lupa = kena tangkap |
| **Tangkap** | Pemain lain bisa menghukum pemain yang lupa menyerukan UNI |
| **Tantang Wild Draw Four** | Tantang pemain jika curiga mereka masih punya kartu lain yang cocok |
| **Sembunyikan Kartu** | Sembunyikan kartu tertentu dari penglihatan pemain lain |
| **God's Hand** | Kejadian acak (~15%) yang memindahkan kartu secara acak antar pemain |
| **Save & Load** | Simpan dan lanjutkan sesi permainan kapan saja |
| **Sistem Poin** | Pemenang ditentukan berdasarkan nilai sisa kartu di tangan lawan |

---

## Daftar Perintah Permainan

### Menu Utama
| Perintah | Fungsi |
|---|---|
| `start.` | Memulai sesi permainan baru |
| `anggota.` | Melihat daftar anggota tim pengembang |
| `panduan.` | Membaca panduan dan aturan bermain |
| `exit.` | Keluar dari program |

### Saat Bermain
| Perintah | Fungsi |
|---|---|
| `lihatKartu.` | Melihat kartu di tangan pemain aktif |
| `lihatCommand.` | Melihat daftar perintah yang tersedia |
| `mainkanKartu(NomorUrut).` | Memainkan kartu ke meja sesuai nomor urut |
| `uni(NomorUrut).` | Memainkan kartu saat tersisa 2 (menjadi 1) |
| `ambilKartu.` | Mengambil kartu dari deck |
| `tantang.` | Menantang efek Wild Draw Four pemain sebelumnya |
| `tangkap(Nama).` | Menangkap pemain yang lupa menyerukan UNI |
| `sembunyikanKartu(NomorUrut).` | Menyembunyikan kartu dari pemain lain |
| `tampilkanKartu.` | Menampilkan kembali semua kartu tersembunyi |
| `godsHand.` | Memicu kejadian God's Hand secara acak |
| `cekInfo.` | Melihat kartu teratas meja dan status semua pemain |
| `saveGame.` | Menyimpan status permainan saat ini ke file |
| `loadGame.` | Memuat kembali permainan yang tersimpan |

---

## Anggota Kelompok

**InfokanMabarEpEp — Kelompok G08**

| No | Nama | NIM |
|---|---|---|
| 1 | Ghina Emelia Yantes | 13525119 |
| 2 | Sahla Nailah Salsabilla | 13525134 |
| 3 | Cathrine Angel Siburian | 13525138 |
| 4 | Nayla Putri Ghaisani | 13525140 |

---

*Dibuat sebagai proyek mata kuliah — Pemrograman Deklaratif dengan SWI-Prolog.*
