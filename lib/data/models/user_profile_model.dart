class UserProfile {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String? photo;
  final String phone;
  final String? birthday;
  final String? birthdayDate;
  final String gender;

  UserProfile({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    this.photo,
    required this.phone,
    this.birthday,
    this.birthdayDate,
    required this.gender,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      photo: json['personal_photo']?.toString(),
      phone: json['personal_phone']?.toString() ?? '',
      birthday: json['personal_birthday']?.toString(),
      birthdayDate: json['personal_birthday_date']?.toString(),
      gender: json['personal_gender']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'email': email,
      'personal_photo': photo,
      'personal_phone': phone,
      'personal_birthday': birthday,
      'personal_birthday_date': birthdayDate,
      'personal_gender': gender,
    };
  }
}
