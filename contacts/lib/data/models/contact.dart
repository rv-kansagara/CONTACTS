import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  final String avatar;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String? lastName;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String? email;

  @HiveField(5)
  final String? gender;

  @HiveField(6)
  final String occupation;

  @HiveField(7)
  final String country;

  @HiveField(8)
  final bool isFavourite;

  Contact({
    this.avatar = 'assets/icons/user.png',
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.email,
    this.gender,
    required this.occupation,
    required this.country,
    this.isFavourite = false,
  });
}
