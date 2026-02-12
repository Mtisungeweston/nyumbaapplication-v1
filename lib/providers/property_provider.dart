import 'package:flutter/material.dart';
import '../models/property_model.dart';
import '../models/location_model.dart';
import '../services/location_service.dart';

class PropertyProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();

  List<PropertyModel> _properties = [];
  List<PropertyModel> _filteredProperties = [];
  PropertyModel? _selectedProperty;

  // Filter criteria
  double _minPrice = 0;
  double _maxPrice = 10000000;
  double _radiusKm = 50;
  String? _selectedDistrict;

  // Getters
  List<PropertyModel> get properties => _filteredProperties.isEmpty
      ? _properties
      : _filteredProperties;
  PropertyModel? get selectedProperty => _selectedProperty;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  double get radiusKm => _radiusKm;
  String? get selectedDistrict => _selectedDistrict;

  /// Initialize with test properties (demo data)
  void initializeWithTestData() {
    _properties = [
      PropertyModel(
        id: '1',
        title: 'Modern Family Home in Blantyre',
        description:
            'A stunning 3-bedroom home with modern amenities, spacious living areas, and a beautiful garden.',
        price: 150000,
        bedrooms: 3,
        bathrooms: 2,
        squareFeet: 2500,
        location: LocationModel(
          latitude: -15.7833,
          longitude: 35.3167,
          address: 'Blantyre, Manase, Malawi',
          city: 'Blantyre',
          district: 'Blantyre',
          country: 'Malawi',
        ),
        imageUrls: ['assets/images/property1.jpg'],
        postedBy: '+265991234567',
        postedByName: 'John Malawi',
        postedByRole: 'landlord',
        postedByPhone: '+265991234567',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        amenities: 'WiFi, Garden, Parking, Security Gate',
        contact: '+265991234567',
        status: 'vacant',
      ),
      PropertyModel(
        id: '2',
        title: 'Luxury Apartment in Lilongwe',
        description:
            'Premium 2-bedroom apartment in the heart of Lilongwe with modern furnishings and excellent security.',
        price: 120000,
        bedrooms: 2,
        bathrooms: 1,
        squareFeet: 1800,
        location: LocationModel(
          latitude: -13.9626,
          longitude: 33.7741,
          address: 'Lilongwe, Area 3, Malawi',
          city: 'Lilongwe',
          district: 'Lilongwe',
          country: 'Malawi',
        ),
        imageUrls: ['assets/images/property2.jpg'],
        postedBy: '+265992345678',
        postedByName: 'Sarah Banda',
        postedByRole: 'agent',
        postedByPhone: '+265992345678',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        amenities: 'WiFi, Gym, Pool, 24/7 Security',
        contact: '+265992345678',
        status: 'occupied',
      ),
      PropertyModel(
        id: '3',
        title: 'Cozy House in Mzuzu',
        description:
            'A comfortable 2-bedroom house perfect for a small family or couple, close to shopping centers.',
        price: 85000,
        bedrooms: 2,
        bathrooms: 1,
        squareFeet: 1200,
        location: LocationModel(
          latitude: -11.4667,
          longitude: 34.0167,
          address: 'Mzuzu, Malawi',
          city: 'Mzuzu',
          district: 'Mzimba',
          country: 'Malawi',
        ),
        imageUrls: ['assets/images/property1.jpg'],
        postedBy: '+265993456789',
        postedByName: 'Peter Chiume',
        postedByRole: 'landlord',
        postedByPhone: '+265993456789',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        amenities: 'Parking, Water Tank, Solar Panels',
        contact: '+265993456789',
        status: 'vacant',
      ),
    ];
    _filteredProperties = List.from(_properties);
    notifyListeners();
  }

  /// Add a new property
  void addProperty(PropertyModel property) {
    _properties.add(property);
    applyFilters();
    notifyListeners();
  }

  /// Update a property
  void updateProperty(String id, PropertyModel updatedProperty) {
    final index = _properties.indexWhere((p) => p.id == id);
    if (index != -1) {
      _properties[index] = updatedProperty;
      applyFilters();
      notifyListeners();
    }
  }

  /// Delete a property
  void deleteProperty(String id) {
    _properties.removeWhere((p) => p.id == id);
    applyFilters();
    notifyListeners();
  }

  /// Get properties by posted user
  List<PropertyModel> getPropertiesByUser(String userId) {
    return _properties.where((p) => p.postedBy == userId).toList();
  }

  /// Select a property to view details
  void selectProperty(PropertyModel property) {
    _selectedProperty = property;
    notifyListeners();
  }

  /// Apply filters to properties
  void applyFilters({
    double? minPrice,
    double? maxPrice,
    double? radiusKm,
    String? district,
    LocationModel? userLocation,
  }) {
    if (minPrice != null) _minPrice = minPrice;
    if (maxPrice != null) _maxPrice = maxPrice;
    if (radiusKm != null) _radiusKm = radiusKm;
    if (district != null) _selectedDistrict = district;

    _filteredProperties = _properties.where((property) {
      // Price filter
      if (property.price < _minPrice || property.price > _maxPrice) {
        return false;
      }

      // District filter
      if (_selectedDistrict != null &&
          property.location.district != _selectedDistrict) {
        return false;
      }

      // Distance/Radius filter
      if (userLocation != null && _radiusKm > 0) {
        final distance = _locationService.calculateDistance(
          userLocation.latitude,
          userLocation.longitude,
          property.location.latitude,
          property.location.longitude,
        );
        if (distance > _radiusKm) {
          return false;
        }
      }

      return true;
    }).toList();

    notifyListeners();
  }

  /// Reset all filters
  void resetFilters() {
    _minPrice = 0;
    _maxPrice = 10000000;
    _radiusKm = 50;
    _selectedDistrict = null;
    _filteredProperties = List.from(_properties);
    notifyListeners();
  }

  /// Search properties by title or description
  void searchProperties(String query) {
    if (query.isEmpty) {
      _filteredProperties = List.from(_properties);
    } else {
      final lowerQuery = query.toLowerCase();
      _filteredProperties = _properties.where((property) {
        return property.title.toLowerCase().contains(lowerQuery) ||
            property.description.toLowerCase().contains(lowerQuery) ||
            property.location.city?.toLowerCase().contains(lowerQuery) ??
            false;
      }).toList();
    }
    notifyListeners();
  }

  /// Get unique districts from all properties
  List<String> getUniqueDistricts() {
    final districts = <String>{};
    for (final property in _properties) {
      if (property.location.district != null) {
        districts.add(property.location.district!);
      }
    }
    return districts.toList();
  }

  /// Get price range from all properties
  Map<String, double> getPriceRange() {
    if (_properties.isEmpty) {
      return {'min': 0, 'max': 1000000};
    }
    final prices = _properties.map((p) => p.price).toList();
    return {
      'min': prices.reduce((a, b) => a < b ? a : b),
      'max': prices.reduce((a, b) => a > b ? a : b),
    };
  }

  /// Update property status (vacant/occupied)
  Future<void> updatePropertyStatus(String propertyId, String newStatus) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final propertyIndex = _properties.indexWhere((p) => p.id == propertyId);
    if (propertyIndex != -1) {
      _properties[propertyIndex] = _properties[propertyIndex].copyWith(
        status: newStatus,
      );

      // Update selected property if it's being viewed
      if (_selectedProperty?.id == propertyId) {
        _selectedProperty = _properties[propertyIndex];
      }

      // Refresh filters
      applyFilters(
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        district: _selectedDistrict,
        radiusKm: _radiusKm,
      );

      notifyListeners();
    }
  }

  /// Check if property is available (vacant)
  bool isPropertyAvailable(PropertyModel property) {
    return property.status.toLowerCase() == 'vacant';
  }
}
