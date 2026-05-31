# UNI — Praktikum / Tugas Besar

> Implementasi permainan kartu UNO dalam bahasa pemrograman **Prolog** dengan berbagai fitur tambahan seperti tantangan Wild Draw Four, seruan UNI, penyembunyian kartu, kejadian acak God's Hand, kartu spesial Mimic, serta mode turnamen 2v2.

## Table of Contents
- [General Information](#general-information)
- [Team Members](#team-members)
- [How to Run](#how-to-run)
- [Program Structure](#program-structure)
- [Features](#features)
- [Commands](#commands)

## General Information

UNI adalah permainan kartu berbasis teks yang diimplementasikan menggunakan **GNU Prolog**. Permainan ini terinspirasi dari UNO, dimainkan oleh 2–4 pemain secara bergantian di satu perangkat. Setiap pemain mendapat 7 kartu acak dari deck 108 kartu. Tujuan utamanya adalah menjadi pemain pertama yang menghabiskan semua kartu di tangan.

Permainan ini memiliki beberapa fitur bonus di luar aturan UNO standar:
- **Tantang** — Pemain bisa menantang legalitas Wild Draw Four.
- **Seruan UNI** — Wajib menyerukan UNI saat kartu tersisa 2, atau bisa ditangkap!
- **Sembunyikan Kartu** — Sembunyikan kartu tertentu dari pandangan pemain lain.
- **God's Hand** — Kejadian acak (~15%) yang memindahkan kartu antar pemain secara tak terduga. Hanya bisa dicoba sekali per giliran.
- **Mimic Card** — Kartu hitam spesial yang menyalin efek kartu aksi terakhir yang dimainkan.
- **Mode Turnamen** — Mode permainan 2v2 untuk tepat 4 pemain, lengkap dengan sistem tim acak, pertukaran kartu antar rekan tim, dan penentuan pemenang berbasis total poin tim.

## Team Members

| **NIM** | **Nama** |
| :------: | :-------------------: |
| 13525119 | Ghina Emelia Yantes |
| 13525134 | Sahla Nailah Salsabilla |
| 13525138 | Cathrine Angel Siburian |
| 13525140 | Nayla Putri Ghaisani |

## How to Run

1. Install [GNU Prolog](http://www.gprolog.org/).
2. Clone repository ini.
```
$ git clone https://github.com/ghinayantes/IF1221_G08_InfokanMabarEpEp.git
```
3. Masuk ke direktori `src`.
```
$ cd IF1221_G08_InfokanMabarEpEp/src
```
4. Jalankan GNU Prolog dengan file utama.
```
$ gprolog --consult-file main.pl
```
5. Program akan terbuka otomatis. Untuk memulai permainan, ketik:
```prolog
?- start.
```
6. Pilih mode permainan:
   - `1` — Mode Klasik (2–4 pemain, individu)
   - `2` — Mode Turnamen (tepat 4 pemain, sistem tim 2v2)

> **Catatan:** File save/load (`.txt`) harus disimpan di direktori yang sama tempat `gprolog` dijalankan. Pastikan direktori tersebut memiliki izin tulis.

## Program Structure

```
.
│   README.md
│
└───docs
│   ├───Milestone1_G08.pdf
│   ├───Milestone2_G08.pdf
│   └───Laporan_G08.pdf
└───src
    │
    ├───main.pl
    ├───startgame.pl
    ├───kartu.pl
    ├───distribusiKartu.pl
    ├───pemain.pl
    ├───lihatKartu.pl
    ├───lihatCommand.pl
    ├───mainkanKartu.pl
    ├───ambilKartu.pl
    ├───uni.pl
    ├───tangkap.pl
    ├───tantang.pl
    ├───sembunyikanKartu.pl
    ├───godsHand.pl
    ├───mimicCard.pl
    ├───cekInfo.pl
    ├───endGame.pl
    ├───saveGame.pl
    ├───loadGame.pl
    ├───turnamen.pl          
    └───swapKartu.pl         
```

## Features

| Fitur | Deskripsi |
| :--- | :--- |
| **Multi-Pemain** | Mendukung 2–4 pemain (klasik) atau tepat 4 pemain (turnamen) dengan nama unik berawalan huruf kapital |
| **Deck Standar** | 108 kartu + 4 kartu Mimic diacak tiap sesi |
| **Kartu Spesial** | Efek Skip, Reverse, Draw Two, Wild, dan Wild Draw Four berjalan otomatis |
| **Mimic Card** | Kartu hitam yang menyalin efek kartu aksi terakhir; berlaku seperti Wild jika belum ada aksi sebelumnya |
| **Seruan UNI** | Wajib gunakan `uni(No).` saat kartu tersisa 2; lupa = kena `tangkap` |
| **Tangkap** | Pemain lain bisa menghukum pemain yang lupa menyerukan UNI (+2 kartu penalti) |
| **Tantang Wild Draw Four** | Tantang pemain jika curiga mereka masih bisa mainkan kartu lain |
| **Sembunyikan Kartu** | Sembunyikan kartu tertentu dari penglihatan pemain lain; pemain tersembunyi tidak bisa ditangkap |
| **God's Hand** | Kejadian acak ~15% yang memindahkan kartu secara acak antar pemain; hanya bisa dicoba 1× per giliran |
| **Save & Load** | Simpan dan lanjutkan sesi permainan kapan saja, termasuk data tim di mode turnamen |
| **Sistem Poin** | Mode klasik: pemenang = pemain habis kartu pertama; mode turnamen: tim dengan total poin sisa kartu terkecil |
| **Mode Turnamen** | 4 pemain dibagi acak menjadi 2 tim (2v2); dilengkapi `swapKartu`, tampilan kartu rekan tim, dan endGame berbasis poin tim |

## Commands

### Menu Utama
| Perintah | Fungsi |
| :--- | :--- |
| `start.` | Memulai sesi permainan baru (pilih mode klasik atau turnamen) |
| `anggota.` | Melihat daftar anggota tim pengembang |
| `panduan.` | Membaca panduan lengkap dan aturan bermain |
| `help.` | Melihat daftar perintah singkat saat bermain |
| `exit.` | Keluar dari program |

### Saat Bermain — Aksi Utama (mengakhiri giliran)
| Perintah | Fungsi |
| :--- | :--- |
| `mainkanKartu(No).` | Memainkan kartu ke meja sesuai nomor urut |
| `uni(No).` | Memainkan kartu saat tersisa 2 (menjadi 1); wajib dipakai |
| `ambilKartu.` | Mengambil 1 kartu dari deck |
| `tantang.` | Menantang efek Wild Draw Four pemain sebelumnya |
| `sembunyikanKartu(No).` | Menyembunyikan kartu ke-No dari pemain lain |
| `godsHand.` | Memicu kejadian God's Hand secara acak (1× per giliran) |
| `swapKartu(NoKu, NoTeman).` | *(Turnamen)* Tukar kartu ke-NoKu milikmu dengan kartu ke-NoTeman milik rekan setim |

### Saat Bermain — Aksi Pendukung (tidak mengakhiri giliran)
| Perintah | Fungsi |
| :--- | :--- |
| `lihatKartu.` | Melihat kartu di tangan; di mode turnamen juga menampilkan kartu rekan setim |
| `lihatCommand.` | Melihat daftar perintah yang tersedia saat ini |
| `cekInfo.` | Melihat kartu teratas, urutan pemain, jumlah kartu; di mode turnamen menampilkan info tim |
| `tangkap(Nama).` | Menangkap pemain yang lupa menyerukan UNI |
| `tampilkanKartu.` | Menampilkan kembali semua kartu tersembunyi milikmu |
| `saveGame.` | Menyimpan status permainan saat ini ke file `.txt` |
| `loadGame.` | Memuat kembali permainan yang tersimpan |

### Aturan swapKartu (Mode Turnamen)
- Hanya bisa dipakai saat mode turnamen aktif.
- Hanya **sekali per giliran**.
- Tidak bisa dilakukan jika kartu pemain aktif **atau** rekan setim hanya tersisa 1.
- Indeks kartu harus valid (tidak melebihi jumlah kartu masing-masing).
- `swapKartu` adalah **aksi utama** — giliran berpindah setelah berhasil.

## Nilai Kartu (Sistem Poin Akhir)

| Kartu | Nilai |
| :--- | :---: |
| Angka 0 | 1 |
| Angka 1–9 | sesuai angka |
| Skip / Reverse / Draw Two | 10 |
| Wild / Wild Draw Four / Mimic | 20 |
