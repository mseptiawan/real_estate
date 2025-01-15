import 'package:flutter/material.dart';
import 'package:real_estate/models/property.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/data.dart';

class DetailScreen extends StatefulWidget {
  final Property property;

  const DetailScreen({super.key, required this.property});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  Future<void> _loadFavoriteStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favoriteHomes = prefs.getStringList('favoriteHomes') ?? [];
      setState(() {
        isFavorite = favoriteHomes.contains(widget.property.name);
      });
    } catch (e) {
      print("Error loading favorite status: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _toggleFavorite() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favoriteHomes = prefs.getStringList('favoriteHomes') ?? [];

      if (isFavorite) {
        favoriteHomes.remove(widget.property.name);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${widget.property.name} Removed from favorites'),
          duration: Duration(seconds: 1),
        ));
      } else {
        favoriteHomes.add(widget.property.name);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${widget.property.name} Added to favorites'),
          duration: Duration(seconds: 1),
        ));
      }
      await prefs.setStringList('favoriteHomes', favoriteHomes);
      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      print("Error toggling favorite status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final property = AppData.properties.firstWhere((p) => p.id == widget.property.id);
    final agent = AppData.agents.firstWhere((a) => a.id == property.agent);
    final tipe = AppData.propertyTypes.firstWhere((a) => a.id == property.type);

    return Scaffold(
      appBar: AppBar(
        title: Text(property.name),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: _toggleFavorite,
          )
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                      child: property.images.isNotEmpty
                          ? Image.asset(
                              '${property.images[0]}',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              fit: BoxFit.cover,
                            )
                          : Container(color: Colors.grey), 
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Chip(
                        label: Text(
                          'Rp ${property.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        property.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tipe: ${tipe.name}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              _buildDetailRow('Luas Bangunan', '${property.buildingArea} m²'),
                              _buildDetailRow('Luas Tanah', '${property.surfaceArea} m²'),
                              _buildDetailRow('Kamar Tidur', '${property.beds}'),
                              _buildDetailRow('Kamar Mandi', '${property.baths}'),
                              _buildDetailRow('Fasilitas', property.facility),
                              _buildDetailRow('Sertifikat', property.certificate),
                              _buildDetailRow('Alamat', property.location),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        property.description,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.08,
                          backgroundImage: AssetImage(agent.photo),
                        ),
                        title: Text(
                          agent.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(agent.email, style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(height: 4),
                            Text(agent.phone, style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
