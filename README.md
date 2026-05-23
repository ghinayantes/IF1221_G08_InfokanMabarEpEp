# UNI — Praktikum / Tugas Besar

> Implementasi permainan kartu UNO dalam bahasa pemrograman **Prolog** dengan berbagai fitur tambahan seperti tantangan Wild Draw Four, seruan UNI, penyembunyian kartu, dan kejadian acak God's Hand.

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
- **God's Hand** — Kejadian acak (~15%) yang memindahkan kartu antar pemain secara tak terduga.

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

## Program Structure

```
.
│   README.md
│
└───docs
│   ├───Milestone1_G08.pdf
│   └───Milestone2_G08.pdf
│
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
    ├───cekInfo.pl
    ├───endGame.pl
    ├───saveGame.pl
    └───loadGame.pl
```

## Features

| Fitur | Deskripsi |
| :--- | :--- |
| **Multi-Pemain** | Mendukung 2–4 pemain dengan nama unik berawalan huruf kapital |
| **Deck Standar** | 108 kartu (angka 0–9, Skip, Reverse, Draw Two, Wild, Wild Draw Four) diacak tiap sesi |
| **Kartu Spesial** | Efek Skip, Reverse, Draw Two, Wild, dan Wild Draw Four berjalan otomatis |
| **Seruan UNI** | Wajib gunakan `uni(No).` saat kartu tersisa 2; lupa = kena `tangkap` |
| **Tangkap** | Pemain lain bisa menghukum pemain yang lupa menyerukan UNI (+2 kartu penalti) |
| **Tantang Wild Draw Four** | Tantang pemain jika curiga mereka masih bisa mainkan kartu lain |
| **Sembunyikan Kartu** | Sembunyikan kartu tertentu dari penglihatan pemain lain |
| **God's Hand** | Kejadian acak ~15% yang memindahkan kartu secara acak antar pemain |
| **Save & Load** | Simpan dan lanjutkan sesi permainan kapan saja |
| **Sistem Poin** | Pemenang ditentukan berdasarkan nilai sisa kartu di tangan lawan |

## Commands

### Menu Utama
| Perintah | Fungsi |
| :--- | :--- |
| `start.` | Memulai sesi permainan baru |
| `anggota.` | Melihat daftar anggota tim pengembang |
| `panduan.` | Membaca panduan dan aturan bermain |
| `exit.` | Keluar dari program |

### Saat Bermain
| Perintah | Fungsi |
| :--- | :--- |
| `lihatKartu.` | Melihat kartu di tangan pemain aktif |
| `lihatCommand.` | Melihat daftar perintah yang tersedia |
| `mainkanKartu(No).` | Memainkan kartu ke meja sesuai nomor urut |
| `uni(No).` | Memainkan kartu saat tersisa 2 (menjadi 1) |
| `ambilKartu.` | Mengambil kartu dari deck |
| `tantang.` | Menantang efek Wild Draw Four pemain sebelumnya |
| `tangkap(Nama).` | Menangkap pemain yang lupa menyerukan UNI |
| `sembunyikanKartu(No).` | Menyembunyikan kartu dari pemain lain |
| `tampilkanKartu.` | Menampilkan kembali semua kartu tersembunyi |
| `godsHand.` | Memicu kejadian God's Hand secara acak |
| `cekInfo.` | Melihat kartu teratas meja dan status semua pemain |
| `saveGame.` | Menyimpan status permainan saat ini ke file |
| `loadGame.` | Memuat kembali permainan yang tersimpan |
