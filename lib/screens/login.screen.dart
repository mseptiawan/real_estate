import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  Future<bool> _verifyUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    return savedEmail == email && savedPassword == password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _email = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Diperlukan Email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Masukkan alamat email yang valid';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => _password = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Diperlukan Password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    bool isVerified = await _verifyUser(_email!, _password!);

                    if (isVerified) {
                      Fluttertoast.showToast(msg: 'Login Sukses!');
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Email atau Password tidak valid');
                    }
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
