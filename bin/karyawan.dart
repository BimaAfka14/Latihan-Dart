import 'package:intl/intl.dart';

const UMR = 2900000;

var numFormat = NumberFormat("#,000");
var dateFormat = DateFormat("yyyy-MM-dd");

abstract class Karyawan {
  // superclass
  String npp; //not nullable
  String nama;
  String? alamat; // nullable
  int thnMasuk;
  int _gaji = UMR;

  Karyawan(this.npp, this.nama, {this.thnMasuk = 2015});

  void presensi(DateTime jamMasuk);

  String deskripsi() {
    String teks = """==================================
  NPP = $npp
  Nama = $nama
  Gaji = ${numFormat.format(gaji)}""";
    if (alamat != null) {
      teks += '\nAlamat : $alamat';
    }
    return teks;
  }

  //setter dengan arrow function
  int get tunjangan;

  int get gaji => (_gaji + tunjangan);

  set gaji(int gaji) {
    if (gaji < UMR) {
      _gaji = UMR;
      print("Gaji tidak boleh di bawah UMR");
    } else {
      _gaji = gaji;
    }
  }
}

class StaffBiasa extends Karyawan {
  StaffBiasa(super.npp, super.nama, {thnMasuk = 2015});

  @override
  void presensi(DateTime jamMasuk) {
    {
      if (jamMasuk.hour > 8) {
        print("$nama datang terlambat!");
      } else {
        print("$nama datang tepat waktu");
      }
    }
  }

  @override
  // TODO: implement tunjangan
  int get tunjangan => ((2024 - thnMasuk) < 5)
      ? 500000
      : 1000000; // ternary operator menjadi arrow function
}

enum TipeJabatan { kabag, manajer, direktur }

class Pejabat extends Karyawan {
  TipeJabatan jabatan;

  Pejabat(super.npp, super.nama, this.jabatan, {thnMasuk = 2015});

  @override
  void presensi(DateTime jamMasuk) {
    // TODO: implement presensi
    if (jamMasuk.hour > 10) {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang terlambat!");
    } else {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  }

  @override
  // TODO: implement tunjangan
  int get tunjangan {
    if (jabatan == TipeJabatan.kabag) {
      return 1500000;
    } else if (jabatan == TipeJabatan.manajer) {
      return 2500000;
    } else {
      return 5000000;
    }
  }

  @override
  String deskripsi() {
    // TODO: implement deskripsi
    String teks = super.deskripsi();
    teks += "\n Jabatan : ${jabatan.name}";
    return teks;
  }
}

//  => ((2024 - thnmasuk) < 5)
//       ? 500000
//       : 1000000; // ternary operator menjadi arrow function


//  {
//     if (jamMasuk.hour > 8) {
//       print("$nama datang terlambat!");
//     } else {
//       print("$nama datang tepat waktu");
//     }
//   }