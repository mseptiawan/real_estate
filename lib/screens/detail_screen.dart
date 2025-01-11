import 'package:flutter/material.dart';
import 'package:real_estate/screens/models/property.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/data.dart';

class DetailScreen extends StatefulWidget {
  final Property property;

  const DetailScreen({super.key, required this.property});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;
  int quantity = 1;
  TextEditingController quantityController = TextEditingController();

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteHomes = prefs.getStringList('favoriteHomes') ?? [];
    setState(() {
      // Mengecek apakah produk ini ada dalam daftar favorit
      isFavorite = favoriteHomes.contains(widget.property.name);
    });
  }

  @override
  void initState() {
    super.initState();
    quantityController.text = quantity.toString();
    _loadFavoriteStatus();
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteHomes = prefs.getStringList('favoriteHomes') ?? [];

    if (isFavorite) {
      // Jika produk sudah di favoritkan, maka hapus dari daftar favorit
      favoriteHomes.remove(widget.property.name);
      // isFavorite = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${widget.property.name} Removed from favorites'),
        duration: Duration(seconds: 1),
      ));
    } else {
      // Jika produk belum di favoritkan, tambahkan ke daftar favorit
      favoriteHomes.add(widget.property.name);
      // isFavorite = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${widget.property.name} Added to favorites'),
        duration: Duration(seconds: 1),
      ));
    }
    await prefs.setStringList('favoriteHomes', favoriteHomes);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final property =
        AppData.properties.firstWhere((p) => p.id == widget.property.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(property.name),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  '${property.images[0]}',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              // Property details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          property.location,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        IconButton(
                          onPressed: _toggleFavorite,
                          icon: Icon(
                            (isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border),
                            size: 30,
                            color: isFavorite ? Colors.red : null,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      property.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Price: Rp ${(property.price / 1000000000).toStringAsFixed(1)} B',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Property features
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFeatureItem(Icons.bed, '${property.beds} Beds'),
                        _buildFeatureItem(
                            Icons.bathtub, '${property.baths} Baths'),
                        _buildFeatureItem(
                            Icons.square_foot, '${property.size} m²'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
