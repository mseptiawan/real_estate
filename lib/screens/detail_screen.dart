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
    final agent = AppData.agents.firstWhere((a) => a.id == property.agent);
    final tipe = AppData.propertyTypes.firstWhere((a) => a.id == property.type);

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rp ${property.price}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          property.name,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tanggal posting ${property.postingDay}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'DETAIL ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tipe ${tipe.name}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        // Text di sebelah kiri
                        Text(
                          'LUAS BANGUNAN',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        // Spacer agar teks berada di tengah
                        Spacer(),
                        // Teks nilai properti di tengah
                        Text(
                          '${property.buildingArea}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Text di sebelah kiri
                        Text(
                          'LUAS TANAH',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        // Spacer agar teks berada di tengah
                        Spacer(),
                        // Teks nilai properti di tengah
                        Text(
                          '${property.surfaceArea}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'KAMAR TIDUR                     ${property.beds}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'KAMAR MANDI                     ${property.baths}:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'FASILITAS                      ${property.facility}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LANTAI                         ${property.floor}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SERTIFIKAT                     ${property.certificate}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ALAMAT LOKASI                  ${property.location}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
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
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(agent.photo),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              agent.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              agent.email,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              agent.phone,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    // Property features
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     _buildFeatureItem(
                    //         Icons.bed, '${property.beds} Kamar tidur'),
                    //     _buildFeatureItem(
                    //         Icons.bathtub, '${property.baths} Kamar mandi'),
                    //     _buildFeatureItem(
                    //         Icons.square_foot, '${property.baths} m²'),
                    //   ],
                    // ),
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
