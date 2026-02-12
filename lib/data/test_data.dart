// TEST DATA - DELETE THIS FILE WHEN USING REAL BACKEND

const String TEST_PHONE = '+265991972355';
const String TEST_OTP = '123456';

enum UserRole { tenant, landlord, agent }

// Mock user for testing
final Map<String, dynamic> mockUser = {
  'id': 'user_001',
  'name': 'Chingoya Banda',
  'phone': TEST_PHONE,
  'role': 'tenant',
  'profilePicture': null, // null for placeholder
  'createdAt': DateTime.now(),
};

// Sample properties with full details
final List<Map<String, dynamic>> mockProperties = [
  {
    'id': '1',
    'name': 'Modern 2-Bedroom Apartment',
    'type': 'rent',
    'price': 150000,
    'currency': 'MWK',
    'bedrooms': 2,
    'bathrooms': 1,
    'size': 120,
    'location': 'Lilongwe City Center',
    'latitude': -13.9626,
    'longitude': 33.7741,
    'description': 'Beautiful modern apartment with excellent natural light, fully furnished kitchen, and modern amenities.',
    'image': 'https://via.placeholder.com/300x200?text=Apartment+1',
    'images': [
      'https://via.placeholder.com/300x200?text=Apartment+1',
      'https://via.placeholder.com/300x200?text=Apartment+2',
      'https://via.placeholder.com/300x200?text=Apartment+3',
    ],
    'amenities': ['WiFi', 'Parking', 'Gym', 'Swimming Pool', 'Security'],
    'featured': true,
  },
  {
    'id': '2',
    'name': 'Spacious Family Home',
    'type': 'sale',
    'price': 2500000,
    'currency': 'MWK',
    'bedrooms': 4,
    'bathrooms': 2,
    'size': 350,
    'location': 'Blantyre Suburbs',
    'latitude': -15.7942,
    'longitude': 35.0881,
    'description': 'A stunning 4-bedroom family home with large gardens, gated security, and modern finishes throughout.',
    'image': 'https://via.placeholder.com/300x200?text=House+1',
    'images': [
      'https://via.placeholder.com/300x200?text=House+1',
      'https://via.placeholder.com/300x200?text=House+2',
      'https://via.placeholder.com/300x200?text=House+3',
    ],
    'amenities': ['Garden', 'Security Gate', 'Driveway', 'Laundry Room', 'Study'],
    'featured': true,
  },
  {
    'id': '3',
    'name': 'Studio Apartment near CBD',
    'type': 'rent',
    'price': 80000,
    'currency': 'MWK',
    'bedrooms': 1,
    'bathrooms': 1,
    'size': 45,
    'location': 'Lilongwe CBD',
    'latitude': -13.9833,
    'longitude': 33.7667,
    'description': 'Compact and affordable studio apartment perfect for singles or couples.',
    'image': 'https://via.placeholder.com/300x200?text=Studio',
    'images': [
      'https://via.placeholder.com/300x200?text=Studio+1',
      'https://via.placeholder.com/300x200?text=Studio+2',
    ],
    'amenities': ['WiFi', 'Water Tank', 'Security'],
    'featured': false,
  },
  {
    'id': '4',
    'name': 'Luxury 3-Bed Villa',
    'type': 'sale',
    'price': 3500000,
    'currency': 'MWK',
    'bedrooms': 3,
    'bathrooms': 2,
    'size': 280,
    'location': 'Lilongwe Kafue',
    'latitude': -13.8617,
    'longitude': 33.8125,
    'description': 'Exclusive villa with modern design, solar panels, and stunning views.',
    'image': 'https://via.placeholder.com/300x200?text=Villa',
    'images': [
      'https://via.placeholder.com/300x200?text=Villa+1',
      'https://via.placeholder.com/300x200?text=Villa+2',
      'https://via.placeholder.com/300x200?text=Villa+3',
      'https://via.placeholder.com/300x200?text=Villa+4',
    ],
    'amenities': ['Solar Power', 'Garden', 'Pool', 'Garage', 'Smart Home'],
    'featured': true,
  },
  {
    'id': '5',
    'name': 'Commercial Space for Rent',
    'type': 'rent',
    'price': 250000,
    'currency': 'MWK',
    'bedrooms': 0,
    'bathrooms': 2,
    'size': 200,
    'location': 'Blantyre City Center',
    'latitude': -15.8000,
    'longitude': 35.0833,
    'description': 'Prime commercial space suitable for office or retail.',
    'image': 'https://via.placeholder.com/300x200?text=Commercial',
    'images': [
      'https://via.placeholder.com/300x200?text=Commercial+1',
      'https://via.placeholder.com/300x200?text=Commercial+2',
    ],
    'amenities': ['Security', 'Parking', 'Backup Power'],
    'featured': false,
  },
];

// Filter options
final List<String> propertyTypes = ['All', 'Rent', 'Sale'];
final List<String> locations = ['All', 'Lilongwe', 'Blantyre', 'Kumasi', 'Mzimba'];
final List<String> priceRanges = ['All', '0-100K', '100K-500K', '500K-1M', '1M+'];

// Mock transactions/saved properties
final List<String> savedPropertyIds = ['1', '3'];
