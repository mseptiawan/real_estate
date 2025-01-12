import 'package:flutter/material.dart';
import 'package:real_estate/screens/detail_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/data.dart';
import '../models/property.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String? _userName;
  final _properties = AppData.properties;
  final _propertyTypes = AppData.propertyTypes;
  final _searchController = TextEditingController();
  List<Property> _favoriteHomes = [];

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteHomesNames =
        prefs.getStringList('favoriteHomes') ?? [];
    setState(() {
      _favoriteHomes = AppData.properties
          .where(
            (product) => favoriteHomesNames.contains(product.name),
          )
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadFavoriteStatus();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('fullName') ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar favorit anda',
          style: TextStyle(
            color: Color.fromARGB(255, 238, 234, 234),
            fontFamily: 'Poppins', // Menggunakan font Poppins
            fontWeight: FontWeight.bold,
            fontSize: 20, // Ukuran font dapat disesuaikan
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.green.shade500, Colors.green.shade300],
                  ),
                ),
              ),

              // Featured Properties
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cek apakah _favoriteHomes kosong
                    if (_favoriteHomes.isEmpty)
                      Text(
                        'Belum ada daftar favorit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    // Tampilkan daftar favorit jika ada
                    ..._favoriteHomes
                        .where((property) => property.isFeatured)
                        .map((property) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildPropertyCard(property),
                            )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyCard(Property property) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(property: property),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Full width image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                property.images[0],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Icon(Icons.home, size: 50, color: Colors.grey[400]),
                ),
              ),
            ),
            // Gradient overlay
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    property.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.white70),
                      const SizedBox(width: 4),
                      Text(
                        property.location,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp ${property.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.bed, size: 16, color: Colors.black),
                              const SizedBox(width: 4),
                              Text(
                                '${property.beds}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.bathtub,
                                  size: 16, color: Colors.black),
                              const SizedBox(width: 4),
                              Text(
                                '${property.baths}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.square_foot,
                                  size: 16, color: Colors.black),
                              const SizedBox(width: 4),
                              Text(
                                '${property}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
