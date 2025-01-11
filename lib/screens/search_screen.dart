import 'package:flutter/material.dart';
import 'models/data.dart';
import 'models/property.dart';
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
    _searchResults = AppData.properties; // Initially show all properties
  }

  void _searchProperties(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults =
            AppData.properties; // Show all properties if search is empty
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
        title: const Text('Temukan propertimu segera'),
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
            // Search Results
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final property = _searchResults[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to DetailScreen
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailScreen(propertyId: property.id),
                      //   ),
                      // );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        title: Text(property.name),
                        subtitle: Text(property.location),
                        trailing: Text(
                            'Rp ${(property.price / 1000000000).toStringAsFixed(1)} B'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
