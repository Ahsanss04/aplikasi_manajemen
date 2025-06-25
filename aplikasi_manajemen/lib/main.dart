import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/master_barang_page.dart';
import 'pages/master_warna_page.dart';
import 'pages/master_ukuran_page.dart';
import 'pages/laporan_barang_masuk_page.dart';
import 'pages/laporan_barang_keluar_page.dart';
import 'pages/laporan_stok_page.dart';
import 'pages/transaksi_barang_masuk_page.dart';
import 'pages/transaksi_barang_keluar_page.dart';
import 'pages/histori_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Stok Barang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardPage(),
        '/master/barang': (context) => MasterBarangPage(),
        '/master/warna': (context) => MasterWarnaPage(),
        '/master/ukuran': (context) => MasterUkuranPage(),
        '/laporan/barang-masuk': (context) => LaporanBarangMasukPage(),
        '/laporan/barang-keluar': (context) => LaporanBarangKeluarPage(),
        '/laporan/stok': (context) => LaporanStokPage(),
        '/transaksi/barang-masuk': (context) => TransaksiBarangMasukPage(),
        '/transaksi/barang-keluar': (context) => TransaksiBarangKeluarPage(),
        '/histori': (context) => HistoriPage(),
      },
    );
  }
}