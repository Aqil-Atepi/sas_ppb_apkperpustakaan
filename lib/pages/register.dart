import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:perpusbi/pages/login.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nama = TextEditingController();
  final _password = TextEditingController();
  final _alamat = TextEditingController();
  final _tptlahir = TextEditingController();
  final _tgllahir = TextEditingController();
  final _notlp = TextEditingController();
  final _email = TextEditingController();

  void register() async {
    final nama = _nama.text;
    final alamat = _alamat.text;
    final tptlahir = _tptlahir.text;
    final tgllahir = _tgllahir.text;
    final notlp = _notlp.text;
    final email = _email.text;
    final pass = _password.text;

    final url = Uri.parse(
      "http://192.168.0.19/flutter/uas_perpus/register.php",
    );

    try {
      final response = await http.post(
        url,
        body: {
          'nama_lengkap': nama,
          'alamat': alamat,
          'tpt_lahir': tptlahir,
          'tgl_lahir': tgllahir,
          'no_tlp': notlp,
          'email': email,
          'pass': pass,
        },
      );

      print('Response body: ${response.body}');

      final data = jsonDecode(response.body);
      if (data['message'] == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registrasi Berhasil! Tunggu Verifikasi Admin'),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registrasi Gagal: ${data['error']}')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan jaringan')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0567F1),
      body: ListView(
        children: [
          const SizedBox(height: 15),

          _registerIcon(),

          const SizedBox(height: 25),

          _registerPanel(),
        ],
      ),
    );
  }

  Container _registerPanel() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      height: 560,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [
          TextField(
            controller: _nama,
            decoration: InputDecoration(
              hintText: 'Nama Lengkap',
              hintStyle: TextStyle(color: Color(0xFFB6B6B6), fontSize: 14),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: _email,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(color: Color(0xFFB6B6B6), fontSize: 14),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: _notlp,
            decoration: InputDecoration(
              hintText: 'Nomor Telepon',
              hintStyle: TextStyle(color: Color(0xFFB6B6B6), fontSize: 14),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: _password,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(color: Color(0xFFB6B6B6), fontSize: 14),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: _alamat,
            decoration: InputDecoration(
              hintText: 'Alamat Rumah',
              hintStyle: TextStyle(color: Color(0xFFB6B6B6), fontSize: 14),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: _tptlahir,
            decoration: InputDecoration(
              hintText: 'Tempat Kelahiran',
              hintStyle: TextStyle(color: Color(0xFFB6B6B6), fontSize: 14),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: _tgllahir,
            decoration: InputDecoration(
              hintText: 'Taggal Kelahiran',
              hintStyle: TextStyle(color: Color(0xFFB6B6B6), fontSize: 14),
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(onPressed: register, child: const Text('Register')),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: Text(
              'Already have an account? Sign In!',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Center _registerIcon() {
    return const Center(
    child: Text(
      'Register',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
  }
}
