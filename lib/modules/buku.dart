class Buku {
  final int? idPeminjaman;      // id_peminjaman bisa null
  final String? tglPinjam;      // tanggal pinjam bisa null
  final String kodeBuku;
  final String cover;
  final String judul;
  final String penulis;
  final String penerbit;
  final String katalog;
  final int stock;              // stock disimpan sebagai int

  const Buku({
    this.idPeminjaman,
    this.tglPinjam,
    required this.kodeBuku,
    required this.cover,
    required this.judul,
    required this.penulis,
    required this.penerbit,
    required this.katalog,
    required this.stock,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      idPeminjaman: json['id_peminjaman'] != null
          ? int.tryParse(json['id_peminjaman'].toString())
          : null,
      tglPinjam: json['tgl_pinjam']?.toString(),
      kodeBuku: json['kode_buku']?.toString() ?? '',
      cover: json['cover']?.toString() ?? '',
      judul: json['judul']?.toString() ?? '',
      penulis: json['penulis']?.toString() ?? '',
      penerbit: json['penerbit']?.toString() ?? '',
      katalog: json['katalog']?.toString() ?? '',
      stock: int.tryParse(json['stock'].toString()) ?? 0,
    );
  }
}
