import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LaporanBarangMasukPage extends StatefulWidget {
  @override
  _LaporanBarangMasukPageState createState() => _LaporanBarangMasukPageState();
}

class _LaporanBarangMasukPageState extends State<LaporanBarangMasukPage> {
  DateTime? _tanggalAwal;
  DateTime? _tanggalAkhir;
  List<dynamic> _laporan = [];
  List<dynamic> _semuaData = [];

  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  Future<void> _ambilLaporan() async {
    if (_tanggalAwal == null || _tanggalAkhir == null) return;

    final response = await http.post(
      Uri.parse('http://localhost/api/get_laporan_barang_masuk.php'),
      body: {
        'tanggal_awal': _formatter.format(_tanggalAwal!),
        'tanggal_akhir': _formatter.format(_tanggalAkhir!),
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _laporan = json.decode(response.body);
      });
    }
  }

  Future<void> _ambilSemuaData() async {
    final response = await http.get(
      Uri.parse('http://localhost/api/get_data_barang_masuk.php'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _semuaData = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _ambilSemuaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan Barang Masuk"),
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

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Filter Tanggal', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Tanggal Awal'),
                    subtitle: Text(_tanggalAwal == null ? '-' : _formatter.format(_tanggalAwal!)),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) setState(() => _tanggalAwal = date);
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Tanggal Akhir'),
                    subtitle: Text(_tanggalAkhir == null ? '-' : _formatter.format(_tanggalAkhir!)),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) setState(() => _tanggalAkhir = date);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _ambilLaporan,
              child: Text('Tampil'),
            ),
            SizedBox(height: 20),
            if (_laporan.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hasil Laporan:', style: TextStyle(fontWeight: FontWeight.bold)),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Barang')),
                      DataColumn(label: Text('Warna')),
                      DataColumn(label: Text('Ukuran')),
                      DataColumn(label: Text('Jumlah')),
                      DataColumn(label: Text('Tanggal')),
                    ],
                    rows: _laporan.asMap().entries.map((entry) {
                      final i = entry.key;
                      final item = entry.value;
                      return DataRow(cells: [
                        DataCell(Text('${i + 1}')),
                        DataCell(Text(item['nama_barang'])),
                        DataCell(Text(item['nama_warna'])),
                        DataCell(Text(item['ukuran'])),
                        DataCell(Text(item['jumlah'].toString())),
                        DataCell(Text(item['tanggal'])),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            SizedBox(height: 30),
            Text('Data Semua Barang Masuk:', style: TextStyle(fontWeight: FontWeight.bold)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('ID Transaksi')),
                  DataColumn(label: Text('Tanggal')),
                  DataColumn(label: Text('Barang')),
                  DataColumn(label: Text('Warna')),
                  DataColumn(label: Text('Ukuran')),
                  DataColumn(label: Text('Jumlah')),
                  DataColumn(label: Text('Status')),
                ],
                rows: _semuaData.asMap().entries.map((entry) {
                  final i = entry.key;
                  final item = entry.value;
                  return DataRow(cells: [
                    DataCell(Text('${i + 1}')),
                    DataCell(Text(item['id_transaksi'])),
                    DataCell(Text(item['tanggal'])),
                    DataCell(Text(item['nama_barang'])),
                    DataCell(Text(item['nama_warna'])),
                    DataCell(Text(item['ukuran'])),
                    DataCell(Text(item['jumlah'].toString())),
                    DataCell(Text(item['status'])),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}