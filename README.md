# Tugas Besar IF2121 Logika Komputasional

> Membuat sebuah game strategi sebagai seorang programmer yang ingin mendominasi dunia dengan menggunakan bahasa pemrograman deklaratif Prolog (GNU Prolog).

## List Anggota Kelompok dewolover (K1):

|   NIM    |           Nama            |
| :------: | :-----------------------: |
| 13522005 |   Ahmad Naufal Ramadan    |
| 13522011 |    Dewantoro Triatmojo    |
| 13522015 |    Yusuf Ardian Sandi     |
| 13522027 | Muhammad Althariq Fairuz  |
| 13522057 | Moh Fairuz Alauddin Yahya |

## How to Run

Pertama, clone repository ini

```shell
git clone https://github.com/GAIB21/tugas-besar-if2121-logika-komputasional-2023-dewolover.git
```

Setelah itu, pergi ke root directory dan pindah ke directory

```shell
cd src
```

Setelah itu, jalankan (pastikan anda sudah install gnu prolog)

```shell
gprolog
```

Lalu load main.pl dengan menjalankan pada terminal gnu prolog

```shell
[main].
```

## Commands

```prolog
startGame.
```

`startGame.` yang digunakan untuk memulai permainan. Pada perintah ini, pengguna akan diminta untuk memasukkan jumlah pemain. Selanjutnya, akan dilakukan pelemparan dadu untuk menentukan urutan giliran pemain. Pengguna juga akan diminta untuk memilih wilayah urut berdasarkan hasil lemparan dadu secara otomatis.

```prolog
displayMap.
```

`displayMap.` adalah command yang digunakan untuk menampilkan map. Command ini dapat digunakan saat pemain telah memulai permainan dengan command start Game

```prolog
placeAutomatic.
```

`placeAutomatic.` adalah command yang digunakan meletakkan tentara tambahan dengan jumlah yang acak pada setiap wilayah yang dimiliki suatu pemain.

```prolog
placeManual(kode_negara, jumlah_tentara).
```

`placeManual(kode_negara, jumlah_tentara).` adalah command yang digunakan untuk meletekkan tentara tambahan secara manual ke wilayah yang dimiliki oleh suatu pemain.

```prolog
endTurn.
```

`endTurn.` adalah command untuk mengakhiri giliran pemain. Pemain selanjutnya akan menerima tambahan tentara sesuai dengan banyaknya wilayah yang dimiliki serta benua yang dikuasai.

```prolog
draft(kode_negara, jumlah_tentara).
```

`draft(kode_negara, jumlah_tentara).` adalah command untuk meletakkan tentara tambahan yang dimiliki oleh pemain ke wilayah yang dimiliki olah pemain.

```prolog
move(kode_negara_1, kode_negara_2, jumlah_tentara)
```

`move(kode_negara_1, kode_negara_2, jumlah_tentara)` adalah command untuk memindahkan tentara milik pemain yang sudah ditempatkan pada suatu wilayah ke wilayah lain yang juga milik pemain tersebut.

```prolog
attack.
```

`attack.` adalah command untuk menyerang wilayah pemain lain yang bertetanggan langsung dengan wilayah yang dipilih oleh pemain tersebut.

```prolog
risk.
```

`risk.` adalah command untuk mendapatkan risk card secara acak. Risk card yang didapatkan oleh pemain dapat menguntungkan pemain atau merugikan pemain tersebut.

```prolog
checkLocationDetail(kode_negara)
```

`checkLocationDetail(kode_negara)` adalah command untuk menampilkan informasi suatu wilayah berupa kode, nama, pemilik, total tentara, dan wilayah tetangga.

```prolog
checkPlayerDetail(player)
```

`checkPlayerDetail(player)` adalah command untuk menampilkan informasi pemain berupa nama, benua, total wilayah yang dimiliki, total tentara aktif, dan total tentara tambahan.

```prolog
checkPlayerTerritories(player)
```

`checkPlayerTerritories(player)` adalah command untuk menampilkan highlight teritori yang dikuasai oleh suatu pemain, berupa nama pemain, benua yang diduduki oleh pemain, wilayah yang dimiliki pemain, dan jumlah tentara pada wilayah tersebut.

```prolog
checkIncomingTroops(player)
```

`checkIncomingTroops(player)` adalah command untuk memeriksa jumlah tentara yang akan didapatkan oleh pemain pada giliran selanjutnya.
