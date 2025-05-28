import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perpusbi/modules/buku.dart';
import 'package:perpusbi/pages/detail_pinjaman.dart'; // pastikan file ini ada

class DaftarPinjamanPage extends StatefulWidget {
  final int idUser;
  const DaftarPinjamanPage({super.key, required this.idUser});

  @override
  State<DaftarPinjamanPage> createState() => _DaftarPinjamanPageState();
}

class _DaftarPinjamanPageState extends State<DaftarPinjamanPage> {
  late Future<List<Buku>> _futurePinjaman;

  Future<List<Buku>> _fetchPinjaman() async {
    final url = Uri.parse(
      'http://192.168.223.9/flutter/uas_perpus/readpinjaman.php?id_user=${widget.idUser}',
    );

    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Buku.fromJson(e)).toList();
    }
    throw Exception('Status code: ${res.statusCode}\n${res.body}');
  }

  @override
  void initState() {
    super.initState();
    _futurePinjaman = _fetchPinjaman();
  }

  Future<void> _refresh() async {
    final fresh = await _fetchPinjaman();
    setState(() {
      _futurePinjaman = Future.value(fresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pinjaman'),
        backgroundColor: const Color(0xFF0567F1),
      ),
      body: FutureBuilder<List<Buku>>(
        future: _futurePinjaman,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final pinjaman = snapshot.data!;
          if (pinjaman.isEmpty) {
            return const Center(child: Text('Belum ada buku yang dipinjam.'));
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: pinjaman.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final b = pinjaman[i];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        b.cover,
                        width: 50,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                    title: Text(
                      b.judul,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('Tanggal pinjam: ${b.tglPinjam ?? "-"}'),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPinjamanPage(buku: b),
                        ),
                      );
                      if (result == true) {
                        await _refresh(); // refresh list jika ada perubahan
                      }
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
