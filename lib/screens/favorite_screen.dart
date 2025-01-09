import 'package:flutter/material.dart';
import 'package:real_estate/screens/detail_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'models/data.dart';
import 'models/property.dart';

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
      List<String> favoriteHomesNames = prefs.getStringList('favoriteHomes') ?? [];
      setState(() {
        _favoriteHomes = AppData.properties.where(
          (product) => favoriteHomesNames.contains(product.name),
        ).toList();
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // User info and avatar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello,',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            Text(
                              _userName ?? 'Loading...',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Colors.green, size: 30),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search properties...',
                          prefixIcon: Icon(Icons.search, color: Colors.green),
                          suffixIcon: Icon(Icons.filter_list, color: Colors.green),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Featured Properties
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Featured Properties',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward, size: 18),
                          label: const Text('See All'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    ..._favoriteHomes
                        .where((property) => property.isFeatured)
                        .map((property) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildPropertyCard(property),
                            ))
                        ,
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
              const Icon(Icons.location_on, size: 16, color: Colors.white70),
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
              'Rp ${(property.price / 1000000000).toStringAsFixed(1)} B',
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
                  Icon(Icons.bathtub, size: 16, color: Colors.black),
                  const SizedBox(width: 4),
                  Text(
                  '${property.baths}',
                  style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.square_foot, size: 16, color: Colors.black),
                  const SizedBox(width: 4),
                  Text(
                  '${property.size}',
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