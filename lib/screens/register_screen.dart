import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _fullName;
  String? _phoneNumber;
  String? _address;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final prefs = await SharedPreferences.getInstance();

      prefs.setString('email', _email!);
      prefs.setString('password', _password!);
      prefs.setString('fullName', _fullName!);
      prefs.setString('phoneNumber', _phoneNumber!);
      prefs.setString('address', _address!);

      print('Email: ${prefs.getString('email')}');
      print('Password: ${prefs.getString('password')}');
      print('Full Name: ${prefs.getString('fullName')}');
      print('Phone Number: ${prefs.getString('phoneNumber')}');
      print('Address: ${prefs.getString('address')}');

      Fluttertoast.showToast(msg: 'Registration Successful!');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.green.shade500,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth > 600 ? 600 : screenWidth * 0.9,
            ),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Color.fromARGB(
                  255, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(
                              255, 0, 0, 0), 
                        ),
                      ),
                      const SizedBox(height: 30),

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nama lengkap',
                          prefixIcon: Icon(Icons.person),
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 31, 18, 18)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 2, 1, 1)),
                          ),
                        ),
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        onSaved: (value) => _fullName = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Full Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Handphone',
                          prefixIcon: Icon(Icons.phone),
                          labelStyle:
                              TextStyle(color: Color.fromARGB(255, 2, 1, 1)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 2, 1, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 2, 1, 1)),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Color.fromARGB(255, 2, 1, 1)),
                        onSaved: (value) => _phoneNumber = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone Number is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          prefixIcon: Icon(Icons.location_on),
                          labelStyle:
                              TextStyle(color: Color.fromARGB(255, 2, 1, 1)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 2, 1, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 2, 1, 1)),
                          ),
                        ),
                        style: TextStyle(color: Color.fromARGB(255, 2, 1, 1)),
                        onSaved: (value) => _address = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Address is required';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Email Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          labelStyle:
                              TextStyle(color: Color.fromARGB(255, 2, 1, 1)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 2, 1, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 2, 1, 1)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Color.fromARGB(255, 2, 1, 1)),
                        onSaved: (value) => _email = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          labelStyle:
                              TextStyle(color: Color.fromARGB(255, 2, 1, 1)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 2, 1, 1)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 2, 1, 1)),
                          ),
                        ),
                        obscureText: true,
                        style: TextStyle(color: Color.fromARGB(255, 2, 1, 1)),
                        onSaved: (value) => _password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return 'Password must contain at least one number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Register Button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          backgroundColor: const Color.fromARGB(255, 245, 245,
                              245), // Tombol dengan warna lebih terang
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _register,
                        label: const Text('Daftar',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 0, 0, 0))),
                      ),
                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          'Sudah punya akun? Login',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
