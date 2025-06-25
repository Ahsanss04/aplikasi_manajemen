import 'package:flutter/material.dart';

class TransaksiBarangMasukPage extends StatelessWidget {
  final List<Map<String, dynamic>> barangMasuk = [
    {
      "id_transaksi": "TRX001",
      "tanggal": "2025-06-21",
      "nama_barang": "Sepatu Sport",
      "warna": "Hitam",
      "ukuran": "42",
      "jumlah": 20,
      "status": "pending"
    },
    {
      "id_transaksi": "TRX002",
      "tanggal": "2025-06-20",
      "nama_barang": "Sepatu Formal",
      "warna": "Coklat",
      "ukuran": "43",
      "jumlah": 15,
      "status": "sukses"
    },
  ];

  String getStatusLabel(String status) {
    switch (status) {
      case 'pending':
        return "⏳ Pending";
      case 'sukses':
      case 'valid':
        return "✅ Valid";
      case 'ditolak':
        return "❌ Ditolak";
      default:
        return "-";
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'sukses':
      case 'valid':
        return Colors.green;
      case 'ditolak':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi Barang Masuk"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigasi ke tambah barang masuk
            },
          )
        ],
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text("No")),
              DataColumn(label: Text("ID Transaksi")),
              DataColumn(label: Text("Tanggal")),
              DataColumn(label: Text("Barang")),
              DataColumn(label: Text("Warna")),
              DataColumn(label: Text("Ukuran")),
              DataColumn(label: Text("Jumlah")),
              DataColumn(label: Text("Status")),
            ],
            rows: barangMasuk.asMap().entries.map((entry) {
              int index = entry.key + 1;
              var data = entry.value;
              return DataRow(
                cells: [
                  DataCell(Text(index.toString())),
                  DataCell(Text(data['id_transaksi'])),
                  DataCell(Text(data['tanggal'])),
                  DataCell(Text(data['nama_barang'])),
                  DataCell(Text(data['warna'])),
                  DataCell(Text(data['ukuran'])),
                  DataCell(Text(data['jumlah'].toString())),
                  DataCell(Text(
                    getStatusLabel(data['status']),
                    style: TextStyle(color: getStatusColor(data['status'])),
                  )),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}