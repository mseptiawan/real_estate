import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _name;
  String? _phone;
  String? _address;
  String? _gender;
  String? _email;

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString(
          'fullName'); 
      _phone = prefs.getString('phoneNumber');
      _address = prefs.getString('address');
      _gender = prefs.getString('gender');
      _email = prefs.getString('email');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _name == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: $_name', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Email: $_email', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Phone: $_phone', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Address: $_address', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Gender: $_gender', style: TextStyle(fontSize: 18)),
                ],
              ),
      ),
    );
  }
}
