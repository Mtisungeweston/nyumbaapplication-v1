class LocationModel {
  final double latitude;
  final double longitude;
  final String? address;
  final String? city;
  final String? district;
  final String? country;

  LocationModel({
    required this.latitude,
    required this.longitude,
    this.address,
    this.city,
    this.district,
    this.country,
  });

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? city,
    String? district,
    String? country,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      city: city ?? this.city,
      district: district ?? this.district,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'district': district,
      'country': country,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      address: json['address'],
      city: json['city'],
      district: json['district'],
      country: json['country'],
    );
  }
}
