import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../modules/buku.dart';

class BukuDetailPage extends StatelessWidget {
  final Buku buku;
  final int idUser;
  const BukuDetailPage({super.key, required this.buku, required this.idUser});

  Future<void> _pinjamBuku(BuildContext context) async {
    final url = Uri.parse('http://192.168.0.9/flutter/uas_perpus/pinjam.php');

    final res = await http.post(url, body: {
      'id_user': idUser.toString(),
      'kode_buku': buku.kodeBuku,
    });

    final data = jsonDecode(res.body);
    final msg = data['message'];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );

    if (data['success'] == true) {
      Navigator.pop(context, true); // refresh HomePage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buku.judul),
        backgroundColor: const Color(0xFF0567F1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                buku.cover,
                height: 180,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 16),
            Text("Judul: ${buku.judul}", style: const TextStyle(fontSize: 16)),
            Text("Penulis: ${buku.penulis}", style: const TextStyle(fontSize: 16)),
            Text("Penerbit: ${buku.penerbit}", style: const TextStyle(fontSize: 16)),
            Text("Kategori: ${buku.katalog}", style: const TextStyle(fontSize: 16)),
            Text("Stok: ${buku.stock}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.book),
                label: const Text("Pinjam Buku"),
                onPressed: () => _pinjamBuku(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
