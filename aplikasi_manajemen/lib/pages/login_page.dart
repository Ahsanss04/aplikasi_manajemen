import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State< LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {
    final url = Uri.parse("http://localhost/gudangcv/api/login.php"); // ganti dengan IP server jika di Android
    final response = await http.post(
      url,
      body: jsonEncode({
        "username": usernameController.text,
        "password": passwordController.text,
      }),
      headers: {"Content-Type": "application/json"},
    );

    final result = jsonDecode(response.body);
    if (result['success']) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', result['data']['username']);
      await prefs.setString('level', result['data']['level']);

      // Arahkan ke dashboard
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Login Gagal"),
          content: Text(result['message']),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Admin"), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: login, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
