import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MasterWarnaPage extends StatefulWidget {
  @override
  _MasterWarnaPageState createState() => _MasterWarnaPageState();
}

class _MasterWarnaPageState extends State<MasterWarnaPage> {
  List<dynamic> warnaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWarna();
  }

  Future<void> fetchWarna() async {
    final response = await http.get(Uri.parse('http://localhost/gudangcv/api/warna_read.php'));
    if (response.statusCode == 200) {
      setState(() {
        warnaList = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Gagal memuat data warna');
    }
  }

  void hapusWarna(String id) async {
    final response = await http.post(
      Uri.parse('http://localhost/gudangcv/api/warna_delete.php'),
      body: {'id': id},
    );
    if (response.statusCode == 200) {
      fetchWarna();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menghapus warna')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master Warna'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigasi ke halaman tambah warna
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: warnaList.length,
        itemBuilder: (context, index) {
          final warna = warnaList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(warna['nama_warna']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      // Navigasi ke halaman edit warna dengan parameter warna['id_warna']
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Konfirmasi'),
                          content: Text('Yakin ingin menghapus warna ini?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                hapusWarna(warna['id_warna']);
                              },
                              child: Text('Hapus'),
                            ),
                          ],
                        ),
                      );
                    },
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
