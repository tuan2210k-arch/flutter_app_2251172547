import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String appointmentId;
  final String patientId;
  final String doctorId;
  final Timestamp appointmentDate;
  final String appointmentTime;
  final String reason;
  final String status;
  final String? diagnosis;
  final String? prescription;
  final String? notes;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  AppointmentModel({
    required this.appointmentId,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.reason,
    required this.status,
    this.diagnosis,
    this.prescription,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'appointmentId': appointmentId,
      'patientId': patientId,
      'doctorId': doctorId,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'reason': reason,
      'status': status,
      'diagnosis': diagnosis,
      'prescription': prescription,
      'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      appointmentId: map['appointmentId'] ?? '',
      patientId: map['patientId'] ?? '',
      doctorId: map['doctorId'] ?? '',
      appointmentDate: map['appointmentDate'] ?? Timestamp.now(),
      appointmentTime: map['appointmentTime'] ?? '',
      reason: map['reason'] ?? '',
      status: map['status'] ?? 'scheduled',
      diagnosis: map['diagnosis'],
      prescription: map['prescription'],
      notes: map['notes'],
      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
    );
  }

  AppointmentModel copyWith({
    String? appointmentId,
    String? patientId,
    String? doctorId,
    Timestamp? appointmentDate,
    String? appointmentTime,
    String? reason,
    String? status,
    String? diagnosis,
    String? prescription,
    String? notes,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return AppointmentModel(
      appointmentId: appointmentId ?? this.appointmentId,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      diagnosis: diagnosis ?? this.diagnosis,
      prescription: prescription ?? this.prescription,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
