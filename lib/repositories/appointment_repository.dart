import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/appointment_model.dart';
import '../services/firebase_service.dart';

class AppointmentRepository {
  final FirebaseService _firebaseService = FirebaseService();
  static const String _appointmentCollection = 'appointments';

  Future<void> createAppointment({
    required String patientId,
    required String doctorId,
    required Timestamp appointmentDate,
    required String time,
    required String reason,
  }) async {
    try {
      final availableAppointments = await _firebaseService
          .getCollection(_appointmentCollection)
          .where('doctorId', isEqualTo: doctorId)
          .where('appointmentTime', isEqualTo: time)
          .where('appointmentDate', isEqualTo: appointmentDate)
          .where('status',
              whereIn: ['scheduled', 'confirmed', 'completed'])
          .get();

      if (availableAppointments.docs.isNotEmpty) {
        throw Exception(
            'Doctor is not available for this time slot');
      }

      final appointmentId = const Uuid().v4();
      final appointment = AppointmentModel(
        appointmentId: appointmentId,
        patientId: patientId,
        doctorId: doctorId,
        appointmentDate: appointmentDate,
        appointmentTime: time,
        reason: reason,
        status: 'scheduled',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      await _firebaseService
          .getCollection(_appointmentCollection)
          .doc(appointmentId)
          .set(appointment.toMap());
    } catch (e) {
      throw Exception('Failed to create appointment: $e');
    }
  }

  Future<void> confirmAppointment(String appointmentId) async {
    try {
      await _firebaseService
          .getCollection(_appointmentCollection)
          .doc(appointmentId)
          .update({
        'status': 'confirmed',
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to confirm appointment: $e');
    }
  }

  Future<void> completeAppointment({
    required String appointmentId,
    required String diagnosis,
    required String prescription,
    String? notes,
  }) async {
    try {
      await _firebaseService
          .getCollection(_appointmentCollection)
          .doc(appointmentId)
          .update({
        'status': 'completed',
        'diagnosis': diagnosis,
        'prescription': prescription,
        'notes': notes,
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to complete appointment: $e');
    }
  }

  Future<void> cancelAppointment(String appointmentId) async {
    try {
      await _firebaseService
          .getCollection(_appointmentCollection)
          .doc(appointmentId)
          .update({
        'status': 'cancelled',
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to cancel appointment: $e');
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByPatient(
      String patientId) async {
    try {
      final snapshot = await _firebaseService
          .getCollection(_appointmentCollection)
          .where('patientId', isEqualTo: patientId)
          .orderBy('appointmentDate', descending: true)
          .get();

      return snapshot.docs
          .map((doc) =>
              AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get patient appointments: $e');
    }
  }

  Stream<List<AppointmentModel>> getAppointmentsByPatientStream(
      String patientId) {
    try {
      return _firebaseService
          .getCollection(_appointmentCollection)
          .where('patientId', isEqualTo: patientId)
          .snapshots()
          .map((snapshot) {
            final appointments = snapshot.docs
                .map((doc) =>
                    AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
                .toList();
            // Sort by date in app instead of in query
            appointments.sort((a, b) => b.appointmentDate.compareTo(a.appointmentDate));
            return appointments;
          });
    } catch (e) {
      throw Exception('Failed to get patient appointments stream: $e');
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByDoctor(
      String doctorId) async {
    try {
      final snapshot = await _firebaseService
          .getCollection(_appointmentCollection)
          .where('doctorId', isEqualTo: doctorId)
          .orderBy('appointmentDate', descending: true)
          .get();

      return snapshot.docs
          .map((doc) =>
              AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get doctor appointments: $e');
    }
  }

  Stream<List<AppointmentModel>> getAppointmentsByDoctorStream(
      String doctorId) {
    try {
      return _firebaseService
          .getCollection(_appointmentCollection)
          .where('doctorId', isEqualTo: doctorId)
          .orderBy('appointmentDate', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) =>
                  AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList());
    } catch (e) {
      throw Exception('Failed to get doctor appointments stream: $e');
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByDate(String date) async {
    try {
      final dateTime = DateTime.parse(date);
      final startOfDay = Timestamp.fromDate(dateTime);
      final endOfDay = Timestamp.fromDate(
          dateTime.add(const Duration(days: 1)));

      final snapshot = await _firebaseService
          .getCollection(_appointmentCollection)
          .where('appointmentDate', isGreaterThanOrEqualTo: startOfDay)
          .where('appointmentDate', isLessThan: endOfDay)
          .orderBy('appointmentDate')
          .get();

      return snapshot.docs
          .map((doc) =>
              AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get appointments by date: $e');
    }
  }

  Future<AppointmentModel?> getAppointmentById(String appointmentId) async {
    try {
      final doc = await _firebaseService
          .getCollection(_appointmentCollection)
          .doc(appointmentId)
          .get();

      if (doc.exists) {
        return AppointmentModel.fromMap(
            doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get appointment: $e');
    }
  }

  Future<bool> isDoctorAvailable(String doctorId,
      Timestamp appointmentDate, String time) async {
    try {
      final snapshot = await _firebaseService
          .getCollection(_appointmentCollection)
          .where('doctorId', isEqualTo: doctorId)
          .where('appointmentTime', isEqualTo: time)
          .where('appointmentDate', isEqualTo: appointmentDate)
          .where('status',
              whereIn: ['scheduled', 'confirmed', 'completed'])
          .get();

      return snapshot.docs.isEmpty;
    } catch (e) {
      throw Exception('Failed to check doctor availability: $e');
    }
  }
}
