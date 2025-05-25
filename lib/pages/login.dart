import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:perpusbi/pages/home.dart';
import 'package:perpusbi/pages/register.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
  final user = _userController.text.trim();
  final password = _passwordController.text.trim();

  final url = Uri.parse("http://192.168.0.19/flutter/uas_perpus/login.php");

  try {
    final response = await http.post(url, body: {
      'username': user,
      'password': password,
    });

    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);
    if (data['message'] == "Success") {
      // ambil map user dari JSON
      final userData = data['user'] as Map<String, dynamic>;
      final int idUser = int.parse(userData['id_user'].toString());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Berhasil!')),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomePage(idUser: idUser),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Gagal: ${data['error']}')),
      );
    }
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Terjadi kesalahan jaringan')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0567F1),
      body: ListView(
        children: [
          const SizedBox(height: 150),

          _loginIcon(),

          const SizedBox(height: 25),

          _loginPanel(),
        ],
      ),
    );
  }

  Container _loginPanel() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      height: 250,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [
          TextField(
            controller: _userController,
            style: TextStyle(color: Colors.black), 
            decoration: InputDecoration(
              hintText: 'Username',
              hintStyle: TextStyle(color: Color(0xFFB6B6B6), fontSize: 14),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: _passwordController,
            style: TextStyle(color: Colors.black), 
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(color: Color(0xFFB6B6B6), fontSize: 14),
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(onPressed: login, child: const Text('Login')),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RegisterPage()
                )
              );
            },
            child: Text(
              'Dont have an account? Register Now!',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Center _loginIcon() {
  return const Center(
    child: Text(
      'Login',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

}
