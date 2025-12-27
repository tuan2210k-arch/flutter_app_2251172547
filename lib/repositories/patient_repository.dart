import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient_model.dart';
import '../services/firebase_service.dart';

class PatientRepository {
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> addPatient(PatientModel patient) async {
    try {
      await _firebaseService
          .getCollection(FirebaseService.patientCollection)
          .doc(patient.patientId)
          .set(patient.toMap());
    } catch (e) {
      throw Exception('Failed to add patient: $e');
    }
  }

  Future<PatientModel?> getPatientById(String patientId) async {
    try {
      final doc = await _firebaseService
          .getCollection(FirebaseService.patientCollection)
          .doc(patientId)
          .get();

      if (doc.exists) {
        return PatientModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get patient: $e');
    }
  }

  Future<List<PatientModel>> getAllPatients() async {
    try {
      final snapshot = await _firebaseService
          .getCollection(FirebaseService.patientCollection)
          .get();

      return snapshot.docs
          .map((doc) => PatientModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get patients: $e');
    }
  }

  Stream<List<PatientModel>> getAllPatientsStream() {
    try {
      return _firebaseService
          .getCollection(FirebaseService.patientCollection)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) =>
                  PatientModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList());
    } catch (e) {
      throw Exception('Failed to get patients stream: $e');
    }
  }

  Future<void> updatePatient(String patientId, PatientModel patient) async {
    try {
      await _firebaseService
          .getCollection(FirebaseService.patientCollection)
          .doc(patientId)
          .update(patient.toMap());
    } catch (e) {
      throw Exception('Failed to update patient: $e');
    }
  }

  Future<void> deletePatient(String patientId) async {
    try {
      final appointmentSnapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('patientId', isEqualTo: patientId)
          .where('status',
              whereIn: ['scheduled', 'confirmed'])
          .get();

      if (appointmentSnapshot.docs.isNotEmpty) {
        throw Exception(
            'Cannot delete patient with active appointments');
      }

      await _firebaseService
          .getCollection(FirebaseService.patientCollection)
          .doc(patientId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete patient: $e');
    }
  }

  Future<bool> emailExists(String email) async {
    try {
      final snapshot = await _firebaseService
          .getCollection(FirebaseService.patientCollection)
          .where('email', isEqualTo: email)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check email: $e');
    }
  }

  Future<PatientModel?> getPatientByEmail(String email) async {
    try {
      final snapshot = await _firebaseService
          .getCollection(FirebaseService.patientCollection)
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return PatientModel.fromMap(
            snapshot.docs.first.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get patient by email: $e');
    }
  }
}
