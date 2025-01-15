class Property {
  final String id;

  final String name;
  final String location;
  final String price;
  final int beds;
  final int baths;
  final String description;
  final String facility;
  final String floor;
  final String certificate;
  final String buildingArea;
  final List<String> images;
  final String surfaceArea;
  final String type;
  final bool isFeatured;
  final String agent;
  final String postingDay;

  Property({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.beds,
    required this.baths,
    required this.buildingArea,
    required this.surfaceArea,
    required this.certificate,
    required this.facility,
    required this.floor,
    required this.description,
    required this.images,
    required this.type,
    required this.isFeatured,
    required this.agent,
    required this.postingDay,
  });
}
