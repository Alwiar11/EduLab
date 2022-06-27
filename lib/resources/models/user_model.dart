import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String id;
  final String school;
  final String address;
  final String hobby;
  final String vacation;
  final int age;
  final String role;
  final String phoneNumber;
  final String profile;
  final bool isVerified;

  UserModel({
    required this.name,
    required this.school,
    required this.address,
    required this.hobby,
    required this.vacation,
    required this.id,
    required this.age,
    required this.role,
    required this.phoneNumber,
    required this.profile,
    required this.isVerified,
  });

  factory UserModel.fromData(DocumentSnapshot doc) {
    return UserModel(
      name: doc.get('name') ?? "",
      school: doc.get('school') ?? "",
      address: doc.get('address') ?? "",
      hobby: doc.get('hobby') ?? "",
      vacation: doc.get('vacation') ?? '',
      id: doc.id,
      age: doc.get('age') ?? 0,
      role: doc.get('role') ?? '',
      phoneNumber: doc.get('phoneNumber') ?? '',
      profile: doc.get('profile') ?? '',
      isVerified: doc.get('isVerified') ?? false,
    );
  }
}
