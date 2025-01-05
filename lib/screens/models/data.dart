import 'property.dart';
import 'property_type.dart';
import 'agent.dart';

class AppData {
  static final List<PropertyType> propertyTypes = [
    PropertyType(
      id: '1',
      name: 'House',
      icon: 'assets/icons/house.png',
      description: 'Single family homes and townhouses',
    ),
    PropertyType(
      id: '2',
      name: 'Apartment',
      icon: 'assets/icons/apartment.png',
      description: 'Flats and condominiums',
    ),
    PropertyType(
      id: '3',
      name: 'Villa',
      icon: 'assets/icons/villa.png',
      description: 'Luxury vacation homes',
    ),
    PropertyType(
      id: '4',
      name: 'Office',
      icon: 'assets/icons/office.png',
      description: 'Commercial office spaces',
    ),
  ];

  static final List<Agent> agents = [
    Agent(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      phone: '+62812345678',
      photo: 'assets/agents/john.jpg',
      description: 'Luxury property specialist with 10 years experience',
      properties: ['1', '2'],
    ),
    Agent(
      id: '2',
      name: 'Jane Smith',
      email: 'jane@example.com',
      phone: '+62876543210',
      photo: 'assets/agents/jane.jpg',
      description: 'Commercial property expert',
      properties: ['3', '4'],
    ),
  ];

  static final List<Property> properties = [
    Property(
      id: '1',
      name: 'Modern Minimalist House',
      location: 'Jakarta Selatan',
      price: 5500000000,
      beds: 3,
      baths: 2,
      size: 150,
      description: 'Beautiful modern house with garden and pool',
      images: ['assets/properties/house1.jpg', 'assets/properties/house1_2.jpg'],
      type: '1',
      isFeatured: true,
      agent: '1',
      createdAt: DateTime.now(),
    ),
    Property(
      id: '2',
      name: 'Luxury Apartment',
      location: 'Jakarta Pusat',
      price: 3200000000,
      beds: 2,
      baths: 2,
      size: 80,
      description: 'High-rise apartment with city view',
      images: ['assets/properties/apt1.jpg', 'assets/properties/apt1_2.jpg'],
      type: '2',
      isFeatured: true,
      agent: '1',
      createdAt: DateTime.now(),
    ),
    Property(
      id: '3',
      name: 'Beachfront Villa',
      location: 'Bali',
      price: 8000000000,
      beds: 4,
      baths: 3,
      size: 200,
      description: 'Luxurious villa with private beach access',
      images: ['assets/properties/villa1.jpg', 'assets/properties/villa1_2.jpg'],
      type: '3',
      isFeatured: true,
      agent: '2',
      createdAt: DateTime.now(),
    ),
  ];
}