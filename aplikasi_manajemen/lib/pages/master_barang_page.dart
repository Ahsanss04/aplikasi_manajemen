import 'package:flutter/material.dart';

class MasterBarangPage extends StatefulWidget {
  @override
  _MasterBarangPageState createState() => _MasterBarangPageState();
}

class _MasterBarangPageState extends State<MasterBarangPage> {
  List<Map<String, String>> dataBarang = [
    {
      'id': 'BR001',
      'nama': 'Zevma Panthera Pro 1',
      'warna': 'Hitam',
      'ukuran': '41'
    },
    {
      'id': 'BR002',
      'nama': 'Zevma Panthera Pro 2',
      'warna': 'Putih',
      'ukuran': '42'
    },
  ];

  void _tambahBarang() {
    // Navigasi ke halaman tambah barang
  }

  void _editBarang(String id) {
    // Navigasi ke halaman edit barang
  }

  void _hapusBarang(String id) {
    // Konfirmasi dan hapus barang dari data
    setState(() {
      dataBarang.removeWhere((item) => item['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Barang'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _tambahBarang,
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
        itemCount: dataBarang.length,
        itemBuilder: (context, index) {
          final barang = dataBarang[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              title: Text(barang['nama'] ?? ''),
              subtitle: Text(
                  'Warna: ${barang['warna']} | Ukuran: ${barang['ukuran']}'),
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editBarang(barang['id'] ?? ''),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _hapusBarang(barang['id'] ?? ''),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}