import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  final String patientId;
  final String email;
  final String fullName;
  final String phoneNumber;
  final Timestamp dateOfBirth;
  final String gender;
  final String address;
  final String? bloodType;
  final List<String> allergies;
  final String emergencyContact;
  final Timestamp createdAt;

  PatientModel({
    required this.patientId,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    this.bloodType,
    required this.allergies,
    required this.emergencyContact,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'address': address,
      'bloodType': bloodType,
      'allergies': allergies,
      'emergencyContact': emergencyContact,
      'createdAt': createdAt,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      patientId: map['patientId'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? Timestamp.now(),
      gender: map['gender'] ?? '',
      address: map['address'] ?? '',
      bloodType: map['bloodType'],
      allergies: List<String>.from(map['allergies'] ?? []),
      emergencyContact: map['emergencyContact'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  PatientModel copyWith({
    String? patientId,
    String? email,
    String? fullName,
    String? phoneNumber,
    Timestamp? dateOfBirth,
    String? gender,
    String? address,
    String? bloodType,
    List<String>? allergies,
    String? emergencyContact,
    Timestamp? createdAt,
  }) {
    return PatientModel(
      patientId: patientId ?? this.patientId,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
