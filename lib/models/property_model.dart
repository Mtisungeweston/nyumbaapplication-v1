import 'location_model.dart';

class PropertyModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final int bedrooms;
  final int bathrooms;
  final double squareFeet;
  final LocationModel location;
  final List<String> imageUrls;
  final String postedBy; // Phone number or user ID
  final String postedByName;
  final String postedByRole; // 'landlord' or 'agent'
  final String postedByPhone;
  final String? postedByProfile; // Profile image URL
  final DateTime createdAt;
  final bool isFeatured;
  final String? amenities; // Comma-separated list
  final String? contact;
  final String status; // 'vacant' or 'occupied'

  PropertyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.squareFeet,
    required this.location,
    required this.imageUrls,
    required this.postedBy,
    required this.postedByName,
    required this.postedByRole,
    required this.postedByPhone,
    this.postedByProfile,
    required this.createdAt,
    this.isFeatured = false,
    this.amenities,
    this.contact,
    this.status = 'vacant',
  });

  PropertyModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    int? bedrooms,
    int? bathrooms,
    double? squareFeet,
    LocationModel? location,
    List<String>? imageUrls,
    String? postedBy,
    String? postedByName,
    String? postedByRole,
    String? postedByPhone,
    String? postedByProfile,
    DateTime? createdAt,
    bool? isFeatured,
    String? amenities,
    String? contact,
    String? status,
  }) {
    return PropertyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      squareFeet: squareFeet ?? this.squareFeet,
      location: location ?? this.location,
      imageUrls: imageUrls ?? this.imageUrls,
      postedBy: postedBy ?? this.postedBy,
      postedByName: postedByName ?? this.postedByName,
      postedByRole: postedByRole ?? this.postedByRole,
      postedByPhone: postedByPhone ?? this.postedByPhone,
      postedByProfile: postedByProfile ?? this.postedByProfile,
      createdAt: createdAt ?? this.createdAt,
      isFeatured: isFeatured ?? this.isFeatured,
      amenities: amenities ?? this.amenities,
      contact: contact ?? this.contact,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'squareFeet': squareFeet,
      'location': location.toJson(),
      'imageUrls': imageUrls,
      'postedBy': postedBy,
      'postedByName': postedByName,
      'postedByRole': postedByRole,
      'postedByPhone': postedByPhone,
      'postedByProfile': postedByProfile,
      'createdAt': createdAt.toIso8601String(),
      'isFeatured': isFeatured,
      'amenities': amenities,
      'contact': contact,
      'status': status,
    };
  }

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      squareFeet: (json['squareFeet'] ?? 0).toDouble(),
      location: LocationModel.fromJson(json['location'] ?? {}),
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      postedBy: json['postedBy'] ?? '',
      postedByName: json['postedByName'] ?? '',
      postedByRole: json['postedByRole'] ?? 'landlord',
      postedByPhone: json['postedByPhone'] ?? '',
      postedByProfile: json['postedByProfile'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      isFeatured: json['isFeatured'] ?? false,
      amenities: json['amenities'],
      contact: json['contact'],
      status: json['status'] ?? 'vacant',
    );
  }
}
