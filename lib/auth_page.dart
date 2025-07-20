import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chat_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLogin = true;
  String _message = '';

  Future<void> _submit() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _message = 'Username and password cannot be empty.';
      });
      return;
    }

    final url = Uri.parse('http://129.153.113.104:9949/api/${_isLogin ? 'login' : 'register'}');
    final body = jsonEncode({'username': username, 'password': password});

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _message = _isLogin ? 'Login successful!' : 'Registration successful! Please login.';
          if (_isLogin) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatPage(username: username)));
          } else {
            _isLogin = true;
          }
        });
      } else {
        setState(() {
          _message = 'Error: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Network error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Register')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _submit, child: Text(_isLogin ? 'Login' : 'Register')),
            TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                    _message = '';
                  });
                },
                child: Text(_isLogin ? 'No account? Register' : 'Have account? Login')),
            const SizedBox(height: 20),
            Text(_message, style: const TextStyle(color: Colors.red)),
          ]),
        ));
  }
}
