import 'package:flutter/material.dart';

class TransaksiBarangKeluarPage extends StatelessWidget {
  final List<Map<String, dynamic>> dataBarangKeluar = [
    {
      "id_transaksi": "TRX001",
      "tanggal": "2025-06-20",
      "jumlah": 10,
      "status": "pending",
      "nama_barang": "Sepatu Futsal A",
      "nama_warna": "Hitam",
      "ukuran": "42"
    },
    {
      "id_transaksi": "TRX002",
      "tanggal": "2025-06-19",
      "jumlah": 5,
      "status": "valid",
      "nama_barang": "Sepatu Bola B",
      "nama_warna": "Merah",
      "ukuran": "40"
    },
    {
      "id_transaksi": "TRX003",
      "tanggal": "2025-06-18",
      "jumlah": 8,
      "status": "ditolak",
      "nama_barang": "Sepatu Lari C",
      "nama_warna": "Biru",
      "ukuran": "41"
    },
  ];

  Color statusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'valid':
      case 'sukses':
        return Colors.green;
      case 'ditolak':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String statusLabel(String status) {
    switch (status) {
      case 'pending':
        return '⏳ Pending';
      case 'valid':
      case 'sukses':
        return '✅ Valid';
      case 'ditolak':
        return '❌ Ditolak';
      default:
        return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi Barang Keluar"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigasi ke tambah barang keluar
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
      body: ListView.builder(
        itemCount: dataBarangKeluar.length,
        itemBuilder: (context, index) {
          final item = dataBarangKeluar[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(item['nama_barang']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Warna: ${item['nama_warna']} | Ukuran: ${item['ukuran']}'),
                  Text('Jumlah Keluar: ${item['jumlah']}'),
                  Text('Tanggal: ${item['tanggal']}'),
                  Text(
                    statusLabel(item['status']),
                    style: TextStyle(color: statusColor(item['status']), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: item['status'] == 'pending'
                  ? ElevatedButton(
                onPressed: () {
                  // Tambahkan aksi validasi di sini
                },
                child: const Text('Validasi'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              )
                  : null,
            ),
          );
        },
      ),
    );
  }
}