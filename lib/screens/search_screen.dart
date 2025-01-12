import 'package:flutter/material.dart';
import '../models/data.dart';
import '../models/property.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Property> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = []; // Initially no search results
  }

  void _searchProperties(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = []; // Clear results if search is empty
      } else {
        _searchResults = AppData.properties
            .where((property) =>
                property.name.toLowerCase().contains(query.toLowerCase()) ||
                property.location.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temukan propertimu segera',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: _searchProperties,
                decoration: InputDecoration(
                  hintText: 'Cari nama properti atau tempat...',
                  prefixIcon: const Icon(Icons.search, color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            // Only show search results if there is a query
            if (_searchController.text.isNotEmpty) ...[
              // Show results if query is not empty
              Expanded(
                child: _searchResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final property = _searchResults[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to DetailScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    property: property,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Gambar properti di atas
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      property.images.isNotEmpty
                                          ? property.images[0]
                                          : 'assets/images/default_image.jpg',
                                      width: double.infinity,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Judul properti
                                        Text(
                                          property.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Lokasi properti
                                        Text(
                                          property.location,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Harga properti
                                        Text(
                                          'Rp ${property.price}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Tidak ada hasil pencarian.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
              ),
            ]
            // Show message when search query is empty
            else
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Silakan masukkan kata pencarian.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
