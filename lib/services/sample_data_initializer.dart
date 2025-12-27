import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

/// Sample data initialization for Clinic Management App
/// Run this once to populate Firestore with sample data
class SampleDataInitializer {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Add all sample data
  static Future<void> initializeSampleData() async {
    print('Starting sample data initialization...');
    
    await addSamplePatients();
    await addSampleDoctors();
    await addSampleAppointments();
    
    print('✅ Sample data initialization completed!');
  }

  /// Add 5+ sample patients
  static Future<void> addSamplePatients() async {
    print('\n📋 Adding sample patients...');
    
    final patients = [
      {
        'patientId': 'patient_1',
        'email': 'john.doe@email.com',
        'fullName': 'John Doe',
        'phoneNumber': '+1234567890',
        'dateOfBirth': Timestamp.fromDate(DateTime(1990, 5, 15)),
        'gender': 'Male',
        'address': '123 Main St, City',
        'bloodType': 'O',
        'allergies': ['Penicillin', 'Aspirin'],
        'emergencyContact': '+1234567800',
        'createdAt': Timestamp.now(),
      },
      {
        'patientId': 'patient_2',
        'email': 'jane.smith@email.com',
        'fullName': 'Jane Smith',
        'phoneNumber': '+1234567891',
        'dateOfBirth': Timestamp.fromDate(DateTime(1985, 8, 22)),
        'gender': 'Female',
        'address': '456 Oak Ave, Town',
        'bloodType': 'A',
        'allergies': ['Shellfish'],
        'emergencyContact': '+1234567801',
        'createdAt': Timestamp.now(),
      },
      {
        'patientId': 'patient_3',
        'email': 'mike.johnson@email.com',
        'fullName': 'Mike Johnson',
        'phoneNumber': '+1234567892',
        'dateOfBirth': Timestamp.fromDate(DateTime(1992, 3, 10)),
        'gender': 'Male',
        'address': '789 Pine Rd, Village',
        'bloodType': 'B',
        'allergies': [],
        'emergencyContact': '+1234567802',
        'createdAt': Timestamp.now(),
      },
      {
        'patientId': 'patient_4',
        'email': 'emily.wilson@email.com',
        'fullName': 'Emily Wilson',
        'phoneNumber': '+1234567893',
        'dateOfBirth': Timestamp.fromDate(DateTime(1988, 11, 30)),
        'gender': 'Female',
        'address': '321 Elm St, Metro',
        'bloodType': 'AB',
        'allergies': ['Latex'],
        'emergencyContact': '+1234567803',
        'createdAt': Timestamp.now(),
      },
      {
        'patientId': 'patient_5',
        'email': 'david.brown@email.com',
        'fullName': 'David Brown',
        'phoneNumber': '+1234567894',
        'dateOfBirth': Timestamp.fromDate(DateTime(1995, 7, 18)),
        'gender': 'Male',
        'address': '654 Cedar Ln, County',
        'bloodType': 'O',
        'allergies': ['Iodine'],
        'emergencyContact': '+1234567804',
        'createdAt': Timestamp.now(),
      },
    ];

    for (var patient in patients) {
      try {
        await _db
            .collection('patients')
            .doc(patient['patientId'] as String)
            .set(patient);
        print('  ✓ Added patient: ${patient['fullName']}');
      } catch (e) {
        print('  ✗ Error adding patient: $e');
      }
    }
  }

  /// Add 8+ sample doctors with all specializations
  static Future<void> addSampleDoctors() async {
    print('\n👨‍⚕️ Adding sample doctors...');
    
    final doctors = [
      {
        'doctorId': 'doctor_1',
        'email': 'alice.green@clinic.com',
        'fullName': 'Dr. Alice Green',
        'phoneNumber': '+1111111111',
        'specialization': 'Cardiology',
        'qualification': 'MD, Board Certified Cardiologist',
        'experience': 10,
        'consultationFee': 100.0,
        'availableDays': ['Monday', 'Wednesday', 'Friday'],
        'availableTimeSlots': ['09:00', '10:00', '14:00', '15:00'],
        'rating': 4.8,
        'isActive': true,
        'createdAt': Timestamp.now(),
      },
      {
        'doctorId': 'doctor_2',
        'email': 'bob.chen@clinic.com',
        'fullName': 'Dr. Bob Chen',
        'phoneNumber': '+1111111112',
        'specialization': 'Dermatology',
        'qualification': 'MD, Dermatology Specialist',
        'experience': 8,
        'consultationFee': 80.0,
        'availableDays': ['Tuesday', 'Thursday', 'Saturday'],
        'availableTimeSlots': ['08:00', '09:00', '13:00', '16:00'],
        'rating': 4.5,
        'isActive': true,
        'createdAt': Timestamp.now(),
      },
      {
        'doctorId': 'doctor_3',
        'email': 'carol.martinez@clinic.com',
        'fullName': 'Dr. Carol Martinez',
        'phoneNumber': '+1111111113',
        'specialization': 'Pediatrics',
        'qualification': 'MD, Pediatrics',
        'experience': 12,
        'consultationFee': 90.0,
        'availableDays': ['Monday', 'Tuesday', 'Wednesday'],
        'availableTimeSlots': ['09:00', '10:00', '11:00', '15:00'],
        'rating': 4.9,
        'isActive': true,
        'createdAt': Timestamp.now(),
      },
      {
        'doctorId': 'doctor_4',
        'email': 'david.lee@clinic.com',
        'fullName': 'Dr. David Lee',
        'phoneNumber': '+1111111114',
        'specialization': 'Orthopedics',
        'qualification': 'MD, Orthopedic Surgeon',
        'experience': 15,
        'consultationFee': 120.0,
        'availableDays': ['Wednesday', 'Thursday', 'Friday'],
        'availableTimeSlots': ['10:00', '11:00', '14:00', '15:00'],
        'rating': 4.7,
        'isActive': true,
        'createdAt': Timestamp.now(),
      },
      {
        'doctorId': 'doctor_5',
        'email': 'emma.garcia@clinic.com',
        'fullName': 'Dr. Emma Garcia',
        'phoneNumber': '+1111111115',
        'specialization': 'General',
        'qualification': 'MD, General Practice',
        'experience': 7,
        'consultationFee': 70.0,
        'availableDays': ['Monday', 'Wednesday', 'Friday', 'Saturday'],
        'availableTimeSlots': ['08:00', '09:00', '14:00', '16:00'],
        'rating': 4.3,
        'isActive': true,
        'createdAt': Timestamp.now(),
      },
      {
        'doctorId': 'doctor_6',
        'email': 'frank.wilson@clinic.com',
        'fullName': 'Dr. Frank Wilson',
        'phoneNumber': '+1111111116',
        'specialization': 'Cardiology',
        'qualification': 'MD, Interventional Cardiology',
        'experience': 11,
        'consultationFee': 110.0,
        'availableDays': ['Tuesday', 'Thursday', 'Saturday'],
        'availableTimeSlots': ['09:00', '10:00', '15:00', '16:00'],
        'rating': 4.6,
        'isActive': true,
        'createdAt': Timestamp.now(),
      },
      {
        'doctorId': 'doctor_7',
        'email': 'grace.kim@clinic.com',
        'fullName': 'Dr. Grace Kim',
        'phoneNumber': '+1111111117',
        'specialization': 'Dermatology',
        'qualification': 'MD, Cosmetic Dermatology',
        'experience': 9,
        'consultationFee': 85.0,
        'availableDays': ['Monday', 'Tuesday', 'Thursday'],
        'availableTimeSlots': ['10:00', '11:00', '13:00', '14:00'],
        'rating': 4.4,
        'isActive': true,
        'createdAt': Timestamp.now(),
      },
      {
        'doctorId': 'doctor_8',
        'email': 'henry.torres@clinic.com',
        'fullName': 'Dr. Henry Torres',
        'phoneNumber': '+1111111118',
        'specialization': 'Pediatrics',
        'qualification': 'MD, Pediatric Specialist',
        'experience': 13,
        'consultationFee': 95.0,
        'availableDays': ['Wednesday', 'Friday', 'Saturday'],
        'availableTimeSlots': ['09:00', '10:00', '14:00', '15:00'],
        'rating': 4.8,
        'isActive': true,
        'createdAt': Timestamp.now(),
      },
    ];

    for (var doctor in doctors) {
      try {
        await _db
            .collection('doctors')
            .doc(doctor['doctorId'] as String)
            .set(doctor);
        print('  ✓ Added doctor: ${doctor['fullName']} (${doctor['specialization']})');
      } catch (e) {
        print('  ✗ Error adding doctor: $e');
      }
    }
  }

  /// Add 12+ sample appointments with various statuses
  static Future<void> addSampleAppointments() async {
    print('\n📅 Adding sample appointments...');
    
    final now = DateTime.now();
    final appointments = [
      // Scheduled appointments
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_1',
        'doctorId': 'doctor_1',
        'appointmentDate': Timestamp.fromDate(now.add(Duration(days: 5))),
        'appointmentTime': '09:00',
        'reason': 'Regular checkup and heart assessment',
        'status': 'scheduled',
        'diagnosis': null,
        'prescription': null,
        'notes': null,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_2',
        'doctorId': 'doctor_3',
        'appointmentDate': Timestamp.fromDate(now.add(Duration(days: 3))),
        'appointmentTime': '10:00',
        'reason': 'Child vaccination',
        'status': 'scheduled',
        'diagnosis': null,
        'prescription': null,
        'notes': null,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_3',
        'doctorId': 'doctor_4',
        'appointmentDate': Timestamp.fromDate(now.add(Duration(days: 7))),
        'appointmentTime': '14:00',
        'reason': 'Knee pain consultation',
        'status': 'scheduled',
        'diagnosis': null,
        'prescription': null,
        'notes': null,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_4',
        'doctorId': 'doctor_2',
        'appointmentDate': Timestamp.fromDate(now.add(Duration(days: 4))),
        'appointmentTime': '13:00',
        'reason': 'Skin allergy treatment',
        'status': 'scheduled',
        'diagnosis': null,
        'prescription': null,
        'notes': null,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_5',
        'doctorId': 'doctor_5',
        'appointmentDate': Timestamp.fromDate(now.add(Duration(days: 2))),
        'appointmentTime': '08:00',
        'reason': 'General health checkup',
        'status': 'scheduled',
        'diagnosis': null,
        'prescription': null,
        'notes': null,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      // Confirmed appointments
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_1',
        'doctorId': 'doctor_6',
        'appointmentDate': Timestamp.fromDate(now.add(Duration(days: 10))),
        'appointmentTime': '10:00',
        'reason': 'Cardiac stress test',
        'status': 'confirmed',
        'diagnosis': null,
        'prescription': null,
        'notes': null,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_2',
        'doctorId': 'doctor_7',
        'appointmentDate': Timestamp.fromDate(now.add(Duration(days: 6))),
        'appointmentTime': '11:00',
        'reason': 'Skin examination',
        'status': 'confirmed',
        'diagnosis': null,
        'prescription': null,
        'notes': null,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_3',
        'doctorId': 'doctor_8',
        'appointmentDate': Timestamp.fromDate(now.add(Duration(days: 8))),
        'appointmentTime': '15:00',
        'reason': 'Pediatric assessment',
        'status': 'confirmed',
        'diagnosis': null,
        'prescription': null,
        'notes': null,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      // Completed appointments
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_4',
        'doctorId': 'doctor_1',
        'appointmentDate': Timestamp.fromDate(now.subtract(Duration(days: 5))),
        'appointmentTime': '14:00',
        'reason': 'Heart condition follow-up',
        'status': 'completed',
        'diagnosis': 'Mild hypertension, stable',
        'prescription': 'Continue current medications',
        'notes': 'Patient showed good improvement',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_5',
        'doctorId': 'doctor_2',
        'appointmentDate': Timestamp.fromDate(now.subtract(Duration(days: 10))),
        'appointmentTime': '09:00',
        'reason': 'Acne treatment',
        'status': 'completed',
        'diagnosis': 'Moderate acne vulgaris',
        'prescription': 'Topical retinoid cream, benzoyl peroxide',
        'notes': 'Advised to use sunscreen',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_1',
        'doctorId': 'doctor_3',
        'appointmentDate': Timestamp.fromDate(now.subtract(Duration(days: 15))),
        'appointmentTime': '10:00',
        'reason': 'Annual physical exam',
        'status': 'completed',
        'diagnosis': 'Overall health good',
        'prescription': 'Continue healthy lifestyle',
        'notes': 'All vital signs normal',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      // Cancelled appointment
      {
        'appointmentId': const Uuid().v4(),
        'patientId': 'patient_2',
        'doctorId': 'doctor_4',
        'appointmentDate': Timestamp.fromDate(now.subtract(Duration(days: 2))),
        'appointmentTime': '15:00',
        'reason': 'Orthopedic consultation',
        'status': 'cancelled',
        'diagnosis': null,
        'prescription': null,
        'notes': 'Patient requested cancellation',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
    ];

    for (var appointment in appointments) {
      try {
        await _db
            .collection('appointments')
            .doc(appointment['appointmentId'] as String)
            .set(appointment);
        print('  ✓ Added appointment: ${appointment['appointmentId']} (${appointment['status']})');
      } catch (e) {
        print('  ✗ Error adding appointment: $e');
      }
    }
  }
}

// To run this initializer, add it to your app initialization:
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   // Uncomment to initialize sample data (run only once):
//   // await SampleDataInitializer.initializeSampleData();
//
//   runApp(const MyApp());
// }
