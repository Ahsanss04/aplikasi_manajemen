// File: pages/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatelessWidget {
  final int totalStok = 1234;
  final int stokJetma1 = 400;
  final int stokJetma2 = 300;
  final int stokPato1 = 250;

  final List<String> bulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  final Map<int, List<int>> penjualan = {
    2024: [12, 23, 45, 20, 30, 50, 10, 5, 12, 33, 22, 15],
    2025: [10, 30, 25, 15, 45, 40, 20, 22, 33, 18, 20, 17],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Admin"),
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
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Text("Sistem Informasi Stok Barang", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Dashboard Admin"),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCard("Total Stok", totalStok, Colors.red),
                _buildCard("Zevma P. Pro 1", stokJetma1, Colors.orange),
                _buildCard("Zevma P. Pro 2", stokJetma2, Colors.green),
                _buildCard("Zevma Vato E1", stokPato1, Colors.blue),
              ],
            ),
            SizedBox(height: 20),
            Text("Laporan Penjualan Barang Tahun 2024 & 2025", style: TextStyle(fontWeight: FontWeight.bold)),
            _buildSalesTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, int value, Color color) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(title, style: TextStyle(color: Colors.white)),
              SizedBox(height: 8),
              Text(
                NumberFormat.decimalPattern().format(value),
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Icon(Icons.inventory, size: 30, color: Colors.white60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalesTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text("Tahun")),
          ...bulan.map((b) => DataColumn(label: Text(b))),
        ],
        rows: penjualan.entries.map((entry) {
          return DataRow(cells: [
            DataCell(Text(entry.key.toString())),
            ...entry.value.map((v) => DataCell(Text(NumberFormat.decimalPattern().format(v)))),
          ]);
        }).toList(),
      ),
    );
  }
}