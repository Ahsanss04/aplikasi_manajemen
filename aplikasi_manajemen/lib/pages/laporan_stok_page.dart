// laporan_stok_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LaporanStokPage extends StatefulWidget {
  @override
  _LaporanStokPageState createState() => _LaporanStokPageState();
}

class _LaporanStokPageState extends State<LaporanStokPage> {
  List<Map<String, dynamic>> laporanStok = [];
  TextEditingController tglAwalController = TextEditingController();
  TextEditingController tglAkhirController = TextEditingController();

  Future<void> fetchLaporanStok() async {
    final tglAwal = tglAwalController.text;
    final tglAkhir = tglAkhirController.text;
    final response = await http.get(Uri.parse(
        'http://localhost/gudangcv/api/laporan_stok.php?tgl_awal=$tglAwal&tgl_akhir=$tglAkhir'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        laporanStok = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Gagal memuat data stok');
    }
  }

  String keterangan(Map<String, dynamic> row) {
    final masuk = int.parse(row['barang_masuk']);
    final keluar = int.parse(row['barang_keluar']);
    final awal = int.parse(row['stok_awal']);
    final akhir = int.parse(row['stok_akhir']);
    if (masuk > 0) {
      return "Menambahkan $masuk stok dari $awal → $akhir (Masuk)";
    } else if (keluar > 0) {
      return "Mengurangi $keluar stok dari $awal → $akhir (Keluar)";
    } else {
      return "Tidak ada perubahan stok.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporan Stok Barang"),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text("CV. SIJIWADAH JAYA ABADI\nTANGERANG", style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            Divider(),
            ListTile(title: Text("MENU LAPORAN")),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Laporan Barang Masuk"),
              onTap: () => Navigator.pushNamed(context, '/laporan/barang-masuk'),
            ),
            ListTile(
              leading: Icon(Icons.outbox),
              title: Text("Laporan Barang Keluar"),
              onTap: () => Navigator.pushNamed(context, '/laporan/barang-keluar'),
            ),
            ListTile(
              leading: Icon(Icons.storage),
              title: Text("Laporan Stok"),
              onTap: () => Navigator.pushNamed(context, '/laporan/stok'),
            ),
            Divider(),
            ListTile(title: Text("MENU TRANSAKSI")),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Barang Masuk"),
              onTap: () => Navigator.pushNamed(context, '/transaksi/barang-masuk'),
            ),
            ListTile(
              leading: Icon(Icons.remove),
              title: Text("Barang Keluar"),
              onTap: () => Navigator.pushNamed(context, '/transaksi/barang-keluar'),
            ),
            Divider(),
            ListTile(title: Text("MENU MASTER")),
            ListTile(
              leading: Icon(Icons.inventory),
              title: Text("Barang"),
              onTap: () => Navigator.pushNamed(context, '/master/barang'),
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text("Warna"),
              onTap: () => Navigator.pushNamed(context, '/master/warna'),
            ),
            ListTile(
              leading: Icon(Icons.straighten),
              title: Text("Ukuran"),
              onTap: () => Navigator.pushNamed(context, '/master/ukuran'),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Histori"),
              onTap: () => Navigator.pushNamed(context, '/histori'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tglAwalController,
                    decoration: InputDecoration(labelText: 'Tanggal Awal'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        tglAwalController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: tglAkhirController,
                    decoration: InputDecoration(labelText: 'Tanggal Akhir'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        tglAkhirController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: fetchLaporanStok,
                  child: Text("Tampil"),
                )
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text("No")),
                    DataColumn(label: Text("Tanggal")),
                    DataColumn(label: Text("Nama Barang")),
                    DataColumn(label: Text("Keterangan")),
                    DataColumn(label: Text("Stok Awal")),
                    DataColumn(label: Text("Masuk")),
                    DataColumn(label: Text("Keluar")),
                    DataColumn(label: Text("Stok Akhir")),
                  ],
                  rows: laporanStok.asMap().entries.map((entry) {
                    final index = entry.key + 1;
                    final row = entry.value;
                    return DataRow(cells: [
                      DataCell(Text('$index')),
                      DataCell(Text(row['tanggal'] ?? '')),
                      DataCell(Text(row['nama_barang'] ?? '')),
                      DataCell(Text(keterangan(row))),
                      DataCell(Text(row['stok_awal'] ?? '')),
                      DataCell(Text(row['barang_masuk'] ?? '')),
                      DataCell(Text(row['barang_keluar'] ?? '')),
                      DataCell(Text(row['stok_akhir'] ?? '')),
                    ]);
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}