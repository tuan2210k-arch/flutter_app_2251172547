import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/doctor_model.dart';
import '../services/firebase_service.dart';

class DoctorRepository {
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> addDoctor(DoctorModel doctor) async {
    try {
      await _firebaseService
          .getCollection(FirebaseService.doctorCollection)
          .doc(doctor.doctorId)
          .set(doctor.toMap());
    } catch (e) {
      throw Exception('Failed to add doctor: $e');
    }
  }

  Future<DoctorModel?> getDoctorById(String doctorId) async {
    try {
      final doc = await _firebaseService
          .getCollection(FirebaseService.doctorCollection)
          .doc(doctorId)
          .get();

      if (doc.exists) {
        return DoctorModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get doctor: $e');
    }
  }

  Future<List<DoctorModel>> getAllDoctors() async {
    try {
      final snapshot = await _firebaseService
          .getCollection(FirebaseService.doctorCollection)
          .where('isActive', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => DoctorModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get doctors: $e');
    }
  }

  Stream<List<DoctorModel>> getAllDoctorsStream() {
    try {
      return _firebaseService
          .getCollection(FirebaseService.doctorCollection)
          .where('isActive', isEqualTo: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) =>
                  DoctorModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList());
    } catch (e) {
      throw Exception('Failed to get doctors stream: $e');
    }
  }

  Future<List<DoctorModel>> searchDoctors(String query) async {
    try {
      final snapshot = await _firebaseService
          .getCollection(FirebaseService.doctorCollection)
          .where('isActive', isEqualTo: true)
          .get();

      final query_lower = query.toLowerCase();

      return snapshot.docs
          .map((doc) => DoctorModel.fromMap(doc.data() as Map<String, dynamic>))
          .where((doctor) =>
              doctor.fullName.toLowerCase().contains(query_lower) ||
              doctor.specialization.toLowerCase().contains(query_lower))
          .toList();
    } catch (e) {
      throw Exception('Failed to search doctors: $e');
    }
  }

  Future<List<DoctorModel>> getDoctorsBySpecialization(String specialization) async {
    try {
      final snapshot = await _firebaseService
          .getCollection(FirebaseService.doctorCollection)
          .where('specialization', isEqualTo: specialization)
          .where('isActive', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => DoctorModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get doctors by specialization: $e');
    }
  }

  Future<List<DoctorModel>> getAvailableDoctors(String date, String time) async {
    try {
      final snapshot = await _firebaseService
          .getCollection(FirebaseService.doctorCollection)
          .where('isActive', isEqualTo: true)
          .get();

      final doctors = snapshot.docs
          .map((doc) => DoctorModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return doctors.where((doctor) {
        final dayOfWeek = _getDayOfWeek(date);
        final availableOnDay =
            doctor.availableDays.contains(dayOfWeek);
        final hasTimeSlot =
            doctor.availableTimeSlots.contains(time);
        return availableOnDay && hasTimeSlot;
      }).toList();
    } catch (e) {
      throw Exception('Failed to get available doctors: $e');
    }
  }

  String _getDayOfWeek(String dateStr) {
    final date = DateTime.parse(dateStr);
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[date.weekday - 1];
  }

  Future<void> updateDoctor(String doctorId, DoctorModel doctor) async {
    try {
      await _firebaseService
          .getCollection(FirebaseService.doctorCollection)
          .doc(doctorId)
          .update(doctor.toMap());
    } catch (e) {
      throw Exception('Failed to update doctor: $e');
    }
  }

  Future<List<String>> getAllSpecializations() async {
    try {
      final snapshot = await _firebaseService
          .getCollection(FirebaseService.doctorCollection)
          .get();

      final specializations = <String>{};
      for (var doc in snapshot.docs) {
        final doctor =
            DoctorModel.fromMap(doc.data() as Map<String, dynamic>);
        specializations.add(doctor.specialization);
      }
      return specializations.toList();
    } catch (e) {
      throw Exception('Failed to get specializations: $e');
    }
  }
}
