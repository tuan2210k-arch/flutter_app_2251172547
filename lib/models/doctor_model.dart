import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String doctorId;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String specialization;
  final String qualification;
  final int experience;
  final double consultationFee;
  final List<String> availableDays;
  final List<String> availableTimeSlots;
  final double rating;
  final bool isActive;
  final Timestamp createdAt;

  DoctorModel({
    required this.doctorId,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.specialization,
    required this.qualification,
    required this.experience,
    required this.consultationFee,
    required this.availableDays,
    required this.availableTimeSlots,
    required this.rating,
    required this.isActive,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'specialization': specialization,
      'qualification': qualification,
      'experience': experience,
      'consultationFee': consultationFee,
      'availableDays': availableDays,
      'availableTimeSlots': availableTimeSlots,
      'rating': rating,
      'isActive': isActive,
      'createdAt': createdAt,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      doctorId: map['doctorId'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      specialization: map['specialization'] ?? '',
      qualification: map['qualification'] ?? '',
      experience: map['experience'] ?? 0,
      consultationFee: (map['consultationFee'] ?? 0.0).toDouble(),
      availableDays: List<String>.from(map['availableDays'] ?? []),
      availableTimeSlots: List<String>.from(map['availableTimeSlots'] ?? []),
      rating: (map['rating'] ?? 0.0).toDouble(),
      isActive: map['isActive'] ?? true,
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  DoctorModel copyWith({
    String? doctorId,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? specialization,
    String? qualification,
    int? experience,
    double? consultationFee,
    List<String>? availableDays,
    List<String>? availableTimeSlots,
    double? rating,
    bool? isActive,
    Timestamp? createdAt,
  }) {
    return DoctorModel(
      doctorId: doctorId ?? this.doctorId,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      specialization: specialization ?? this.specialization,
      qualification: qualification ?? this.qualification,
      experience: experience ?? this.experience,
      consultationFee: consultationFee ?? this.consultationFee,
      availableDays: availableDays ?? this.availableDays,
      availableTimeSlots: availableTimeSlots ?? this.availableTimeSlots,
      rating: rating ?? this.rating,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
