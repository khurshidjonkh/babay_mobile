class UserProfile {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String? image;

  UserProfile({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.image,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      image: json['image']?.toString(),
    );
  }
}
