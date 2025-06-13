import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perpusbi/modules/buku.dart';
import 'package:perpusbi/pages/buku_detail.dart';
import 'package:perpusbi/pages/daftar_pinjaman.dart';
import 'package:perpusbi/pages/login.dart';
import 'package:perpusbi/pages/riwayat_peminjaman.dart';

class HomePage extends StatefulWidget {
  final int idUser;
  const HomePage({super.key, required this.idUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Buku>> _futureAvailable;

  Future<List<Buku>> _fetchAvailable() async {
    final url = Uri.parse(
      'http://192.168.98.9/flutter/uas_perpus/read.php?id_user=${widget.idUser}',
    );

    final res = await http.get(url);

    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);
      final allBooks = data.map((e) => Buku.fromJson(e)).toList();
      return allBooks.where((book) => book.stock > 0).toList();
    }
    throw Exception('Status code: ${res.statusCode}\n${res.body}');
  }

  @override
  void initState() {
    super.initState();
    _futureAvailable = _fetchAvailable();
  }

  Future<void> _refresh() async {
    final freshData = await _fetchAvailable(); // wait for new data
    setState(() {
      _futureAvailable = Future.value(freshData); // update state with it
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Tersedia'),
        backgroundColor: const Color(0xFF0567F1),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF0567F1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'User: ${widget.idUser}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Perpustakaan App',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Buku Tersedia'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_books),
              title: const Text('Daftar Pinjaman'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DaftarPinjamanPage(idUser: widget.idUser),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Riwayat Pinjaman'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RiwayatPage(idUser: widget.idUser),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Buku>>(
        future: _futureAvailable,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final tersedia = snapshot.data!;
          if (tersedia.isEmpty) {
            return const Center(child: Text('Semua buku sudah Anda pinjam.'));
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: tersedia.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final b = tersedia[i];
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
                    subtitle: Text(b.penulis),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              BukuDetailPage(buku: b, idUser: widget.idUser),
                        ),
                      );

                      if (result == true) {
                        final freshData = await _fetchAvailable();
                        setState(() {
                          _futureAvailable = Future.value(freshData);
                        });
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
