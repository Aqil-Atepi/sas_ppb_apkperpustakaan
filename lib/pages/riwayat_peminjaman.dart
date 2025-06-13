import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RiwayatPage extends StatefulWidget {
  final int idUser;
  const RiwayatPage({super.key, required this.idUser});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  late Future<List<Map<String, dynamic>>> _futureRiwayat;

  Future<List<Map<String, dynamic>>> _fetchRiwayat() async {
    final url = Uri.parse(
        'http://192.168.98.9/flutter/uas_perpus/readriwayat.php?id_user=${widget.idUser}');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List;
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Gagal mengambil data riwayat');
    }
  }

  Future<void> _refresh() async {
    final freshData = await _fetchRiwayat();
    setState(() {
      _futureRiwayat = Future.value(freshData);
    });
  }

  @override
  void initState() {
    super.initState();
    _futureRiwayat = _fetchRiwayat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pinjaman'),
        backgroundColor: const Color(0xFF0567F1),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureRiwayat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final riwayat = snapshot.data!;
          if (riwayat.isEmpty) {
            return const Center(child: Text('Belum ada riwayat pinjaman.'));
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: riwayat.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final b = riwayat[i];
                final judul = b['judul']?.toString() ?? 'Judul tidak tersedia';
                final cover = b['cover']?.toString() ?? '';
                final penulis = b['penulis']?.toString() ?? '';
                final tglPinjam = b['tgl_pinjam'] ?? '-';
                final tglBalik = b['tgl_balik'] ?? '-';


                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
  cover, // <- This should already be a full URL
  width: 50,
  height: 70,
  fit: BoxFit.cover,
  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
)

                    ),
                    title: Text(
                      judul,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (penulis.isNotEmpty) Text(penulis),
                        Text('Tgl Pinjam : $tglPinjam'),
                        Text('Tgl Balik  : $tglBalik'),
                      ],
                    ),
                    // You can add an onTap here if you want to show detail
                    onTap: () {
                      // Optionally, navigate to detail
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
