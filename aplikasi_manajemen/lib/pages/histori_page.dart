import 'package:flutter/material.dart';

class HistoriPage extends StatelessWidget {
  final List<Map<String, dynamic>> logAktivitas = [
    {
      "waktu": "2025-06-21 12:00:00",
      "username": "admin",
      "aksi": "Insert",
      "tabel": "barang",
      "keterangan": "Menambahkan sepatu baru ukuran 42"
    },
    {
      "waktu": "2025-06-20 15:30:00",
      "username": "gudang",
      "aksi": "Update",
      "tabel": "stok_barang",
      "keterangan": "Mengubah stok awal menjadi 100"
    },
    {
      "waktu": "2025-06-19 09:15:00",
      "username": "admin",
      "aksi": "Delete",
      "tabel": "warna",
      "keterangan": "Menghapus warna merah muda"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log Aktivitas"),
        backgroundColor: Colors.teal,
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
        padding: const EdgeInsets.all(8),
        itemCount: logAktivitas.length,
        itemBuilder: (context, index) {
          final log = logAktivitas[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
              ),
              title: Text(log['username']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Waktu: ${log['waktu']}'),
                  Text('Aksi: ${log['aksi']} pada tabel ${log['tabel']}'),
                  Text('Keterangan: ${log['keterangan']}'),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}