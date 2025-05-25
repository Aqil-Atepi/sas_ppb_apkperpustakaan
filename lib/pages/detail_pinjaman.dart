import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perpusbi/modules/buku.dart';

class DetailPinjamanPage extends StatefulWidget {
  final Buku buku;
  const DetailPinjamanPage({super.key, required this.buku});

  @override
  State<DetailPinjamanPage> createState() => _DetailPinjamanPageState();
}

class _DetailPinjamanPageState extends State<DetailPinjamanPage> {
  bool _isCancelling = false;

  Future<void> _cancelPinjaman() async {
    if (widget.buku.idPeminjaman == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID peminjaman tidak tersedia')),
      );
      return;
    }

    setState(() {
      _isCancelling = true;
    });

    try {
      final res = await http.post(
  Uri.parse('http://192.168.0.19/flutter/uas_perpus/cancelpinjaman.php'),
  body: {'id_peminjaman': widget.buku.idPeminjaman.toString(), 'kode_buku': widget.buku.kodeBuku.toString()},
);

print('Response status: ${res.statusCode}');
print('Raw response body: ${res.body}');

if (res.statusCode == 200 && res.body.isNotEmpty) {
  final jsonResponse = jsonDecode(res.body);
  final success = jsonResponse['success'] == true;
  final message = jsonResponse['message'] ?? '';

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pinjaman berhasil dibatalkan')),
    );
    Navigator.pop(context, true);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal membatalkan pinjaman: $message')),
    );
  }
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Server error: ${res.statusCode}')),
  );
}

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error decoding response: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isCancelling = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final buku = widget.buku;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pinjaman'),
        backgroundColor: const Color(0xFF0567F1),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                buku.cover,
                width: 150,
                height: 210,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 150),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            buku.judul,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Penulis: ${buku.penulis}',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Tanggal Pinjam: ${buku.tglPinjam}',
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _isCancelling ? null : _cancelPinjaman,
            icon: _isCancelling
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.cancel),
            label: Text(_isCancelling ? 'Membatalkan...' : 'Batalkan Pinjaman'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
