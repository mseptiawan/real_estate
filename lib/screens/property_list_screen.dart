import 'package:flutter/material.dart';
import '../models/property.dart';

class PropertyListScreen extends StatelessWidget {
  final List<Property> properties;

  const PropertyListScreen({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properti Kategori'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: properties.length,
          itemBuilder: (context, index) {
            final property = properties[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    property
                        .images[0], 
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama properti
                        Text(
                          property.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Lokasi properti
                        Text(
                          property.location,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        // Harga properti
                        Text(
                          'Rp ${property.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
