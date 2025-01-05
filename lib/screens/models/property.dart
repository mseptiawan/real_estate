class Property {
  final String id;
  final String name;
  final String location;
  final double price;
  final int beds;
  final int baths;
  final double size;
  final String description;
  final List<String> images;
  final String type;
  final bool isFeatured;
  final String agent;
  final DateTime createdAt;

  Property({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.beds,
    required this.baths,
    required this.size,
    required this.description,
    required this.images,
    required this.type,
    required this.isFeatured,
    required this.agent,
    required this.createdAt,
  });
}