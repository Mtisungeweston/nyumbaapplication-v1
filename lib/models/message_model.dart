class MessageModel {
  final String id;
  final String fromPhone;
  final String fromName;
  final String toPhone;
  final String toName;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String? propertyId; // Optional: if message is about a specific property

  MessageModel({
    required this.id,
    required this.fromPhone,
    required this.fromName,
    required this.toPhone,
    required this.toName,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.propertyId,
  });

  MessageModel copyWith({
    String? id,
    String? fromPhone,
    String? fromName,
    String? toPhone,
    String? toName,
    String? message,
    DateTime? timestamp,
    bool? isRead,
    String? propertyId,
  }) {
    return MessageModel(
      id: id ?? this.id,
      fromPhone: fromPhone ?? this.fromPhone,
      fromName: fromName ?? this.fromName,
      toPhone: toPhone ?? this.toPhone,
      toName: toName ?? this.toName,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      propertyId: propertyId ?? this.propertyId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromPhone': fromPhone,
      'fromName': fromName,
      'toPhone': toPhone,
      'toName': toName,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'propertyId': propertyId,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      fromPhone: json['fromPhone'] ?? '',
      fromName: json['fromName'] ?? '',
      toPhone: json['toPhone'] ?? '',
      toName: json['toName'] ?? '',
      message: json['message'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      isRead: json['isRead'] ?? false,
      propertyId: json['propertyId'],
    );
  }
}
