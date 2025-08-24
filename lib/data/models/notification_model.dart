class NotificationModel {
  final String? id;
  final String? text;
  final String? previewText;
  final String? image;
  final String? date;
  final String? from;
  final String? notifyType;
  final bool read;

  NotificationModel({
    this.id,
    this.text,
    this.previewText,
    this.image,
    this.date,
    this.from,
    this.notifyType,
    this.read = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final model = NotificationModel(
      id: json['id']?.toString(),
      text: _sanitizeText(json['text']),
      previewText: _sanitizeText(json['preview_text']),
      image: json['image']?.toString(),
      date: json['date']?.toString(),
      from: json['from']?.toString(),
      notifyType: json['notify_type']?.toString(),
      read: json['read'] == true,
    );

    return model;
  }

  // Helper method to sanitize text and handle encoding issues
  static String? _sanitizeText(dynamic text) {
    if (text == null) return null;

    String sanitized = text.toString();

    // Remove any null bytes or invalid characters
    sanitized = sanitized.replaceAll('\x00', '');

    // Trim whitespace
    sanitized = sanitized.trim();

    return sanitized.isEmpty ? null : sanitized;
  }

  // Get full image URL with null safety
  String? get fullImageUrl {
    if (image == null || image!.isEmpty) return null;
    if (image!.startsWith('http')) {
      return image;
    }
    return 'https://babay.pro$image';
  }

  // Get display text with fallback
  String get displayText {
    return text ?? 'No title available';
  }

  // Get display preview text with fallback
  String get displayPreviewText {
    return previewText ?? 'No description available';
  }

  // Get display date with fallback
  String get displayDate {
    return date ?? 'No date available';
  }

  // Get display ID with fallback
  String get displayId {
    return id ?? '0';
  }

  // Copy with read status updated
  NotificationModel copyWith({bool? read}) {
    return NotificationModel(
      id: id,
      text: text,
      previewText: previewText,
      image: image,
      date: date,
      from: from,
      notifyType: notifyType,
      read: read ?? this.read,
    );
  }
}
