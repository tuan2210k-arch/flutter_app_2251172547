# Clinic Management System - Flutter Firebase

A complete Flutter application for managing clinic appointments with Firebase Firestore backend.

**Student ID: 2251172547**

## Project Requirements

### ✅ Database Structure (Firestore Collections)

#### 1. **patients** Collection
- patientId (Document ID)
- email
- fullName
- phoneNumber
- dateOfBirth (Timestamp)
- gender ("male", "female", "other")
- address
- bloodType ("A", "B", "AB", "O", nullable)
- allergies (Array of Strings)
- emergencyContact
- createdAt (Timestamp)

#### 2. **doctors** Collection
- doctorId (Document ID)
- email
- fullName
- phoneNumber
- specialization ("Cardiology", "Dermatology", "Pediatrics", "Orthopedics", "General")
- qualification
- experience (years)
- consultationFee (Double)
- availableDays (Array: ["Monday", "Wednesday", "Friday"])
- availableTimeSlots (Array: ["09:00", "10:00", "14:00"])
- rating (0.0 - 5.0)
- isActive (Boolean)
- createdAt (Timestamp)

#### 3. **appointments** Collection
- appointmentId (Document ID)
- patientId (reference to patients)
- doctorId (reference to doctors)
- appointmentDate (Timestamp)
- appointmentTime (String: "09:00", "10:00", etc.)
- reason (String)
- status ("scheduled", "confirmed", "completed", "cancelled", "no_show")
- diagnosis (String, nullable)
- prescription (String, nullable)
- notes (String, nullable)
- createdAt (Timestamp)
- updatedAt (Timestamp)

## Features Implemented

### 1. Firebase Setup ✅
- Firebase Core initialized
- Firestore Database configured
- Firebase Service Class with singleton pattern

### 2. Model Classes ✅
- PatientModel with allergies array handling
- DoctorModel with availableDays and availableTimeSlots arrays
- AppointmentModel with nullable fields (diagnosis, prescription, notes)

### 3. Repository Pattern (CRUD Operations) ✅

#### PatientRepository
- ✅ addPatient(PatientModel)
- ✅ getPatientById(String)
- ✅ getAllPatients()
- ✅ updatePatient(String, PatientModel)
- ✅ deletePatient(String) - with validation
- ✅ getPatientByEmail(String)
- ✅ emailExists(String)

#### DoctorRepository
- ✅ addDoctor(DoctorModel)
- ✅ getDoctorById(String)
- ✅ getAllDoctors() with stream
- ✅ searchDoctors(String query)
- ✅ getDoctorsBySpecialization(String)
- ✅ getAvailableDoctors(String date, String time)
- ✅ getAllSpecializations()

#### AppointmentRepository
- ✅ createAppointment() - with availability checks
- ✅ confirmAppointment(String)
- ✅ completeAppointment(String, diagnosis, prescription)
- ✅ cancelAppointment(String)
- ✅ getAppointmentsByPatient(String)
- ✅ getAppointmentsByPatient Stream
- ✅ getAppointmentsByDoctor(String)
- ✅ getAppointmentsByDate(String)
- ✅ isDoctorAvailable()

### 4. UI Implementation ✅

#### Authentication
- ✅ Login Screen (email-based)
- ✅ Registration Screen with:
  - Personal information form
  - Date of birth picker
  - Gender selection
  - Blood type selection
  - Allergies multi-select
  - Email validation
  - Duplicate email check

#### Doctor Management
- ✅ Doctor List Screen with:
  - Real-time updates (StreamBuilder)
  - Search functionality
  - Filter by specialization
  - Doctor cards with rating and fee
- ✅ Doctor Detail Screen with:
  - Full doctor information
  - Working days display
  - Available time slots
  - Book appointment button

#### Appointment Management
- ✅ Appointment Booking Screen with:
  - Date picker (validates available days)
  - Time slot selection
  - Reason for visit input
  - Availability validation
  - Consultation fee display
- ✅ My Appointments Screen with:
  - Real-time appointment list
  - Status color coding
  - Appointment details view
- ✅ Appointment Detail Screen with:
  - Full appointment information
  - Doctor details
  - Cancel button (for scheduled/confirmed)
  - Medical info display (diagnosis, prescription)

#### Home Screen
- ✅ Dashboard with quick actions
- ✅ Bottom navigation between screens
- ✅ Logout functionality

### 5. Real-time Features ✅
- StreamBuilder for live doctor list updates
- StreamBuilder for live appointment list updates
- Auto-refresh on data changes

### 6. Error Handling ✅
- Duplicate appointment prevention
- Doctor availability validation
- Email uniqueness check
- User-friendly error messages
- Loading states with spinners

## Sample Data Setup

### Add Sample Patients (5+)
```dart
Patient 1: john.doe@email.com, John Doe, +1234567890, DOB: 1990-05-15, Male, Allergies: [Penicillin, Aspirin]
Patient 2: jane.smith@email.com, Jane Smith, +1234567891, DOB: 1985-08-22, Female, Allergies: [Shellfish]
Patient 3: mike.johnson@email.com, Mike Johnson, +1234567892, DOB: 1992-03-10, Male, Allergies: []
Patient 4: emily.wilson@email.com, Emily Wilson, +1234567893, DOB: 1988-11-30, Female, Allergies: [Latex]
Patient 5: david.brown@email.com, David Brown, +1234567894, DOB: 1995-07-18, Male, Allergies: [Iodine]
```

### Add Sample Doctors (8+)
```dart
Doctor 1: Dr. Alice Green, Cardiology, +1111111111, Experience: 10 years, Fee: $100, Rating: 4.8, Available: Mon/Wed/Fri
Doctor 2: Dr. Bob Chen, Dermatology, +1111111112, Experience: 8 years, Fee: $80, Rating: 4.5, Available: Tue/Thu/Sat
Doctor 3: Dr. Carol Martinez, Pediatrics, +1111111113, Experience: 12 years, Fee: $90, Rating: 4.9, Available: Mon/Tue/Wed
Doctor 4: Dr. David Lee, Orthopedics, +1111111114, Experience: 15 years, Fee: $120, Rating: 4.7, Available: Wed/Thu/Fri
Doctor 5: Dr. Emma Garcia, General, +1111111115, Experience: 7 years, Fee: $70, Rating: 4.3, Available: Mon/Wed/Fri/Sat
Doctor 6: Dr. Frank Wilson, Cardiology, +1111111116, Experience: 11 years, Fee: $110, Rating: 4.6, Available: Tue/Thu/Sat
Doctor 7: Dr. Grace Kim, Dermatology, +1111111117, Experience: 9 years, Fee: $85, Rating: 4.4, Available: Mon/Tue/Thu
Doctor 8: Dr. Henry Torres, Pediatrics, +1111111118, Experience: 13 years, Fee: $95, Rating: 4.8, Available: Wed/Fri/Sat
```

### Add Sample Appointments (12+)
Create various appointments with different statuses:
- scheduled: 5
- confirmed: 3
- completed: 3
- cancelled: 1

## Getting Started

### Prerequisites
- Flutter SDK 3.10+
- Firebase project with Firestore enabled
- Android/iOS device or emulator

### Installation

1. Clone the project
```bash
cd flutter_app_2251172547
flutter pub get
```

2. Configure Firebase
- Update `firebase_options.dart` with your Firebase project credentials
- Create a Firebase project at https://console.firebase.google.com
- Add your platform-specific configurations

3. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart              # App entry point with Firebase init
├── firebase_options.dart  # Firebase configuration
├── models/
│   ├── patient_model.dart
│   ├── doctor_model.dart
│   └── appointment_model.dart
├── services/
│   └── firebase_service.dart  # Firestore singleton
├── repositories/
│   ├── patient_repository.dart
│   ├── doctor_repository.dart
│   └── appointment_repository.dart
└── screens/
    ├── login_screen.dart
    ├── register_screen.dart
    ├── home_screen.dart
    ├── doctor_list_screen.dart
    ├── doctor_detail_screen.dart
    ├── appointment_booking_screen.dart
    ├── my_appointments_screen.dart
    └── appointment_detail_screen.dart
```

## Technologies Used

- **Flutter**: UI framework
- **Firebase Core**: Backend initialization
- **Cloud Firestore**: Database
- **UUID**: Unique ID generation
- **Intl**: Date formatting
- **Provider**: State management (ready for implementation)

## Key Features

1. **Real-time Updates**: Uses Firestore streams for live data
2. **Validation**: Comprehensive input and business logic validation
3. **User-friendly UI**: Material Design 3 with consistent theming
4. **Error Handling**: Graceful error messages and recovery
5. **Responsive Design**: Works on various screen sizes

## Testing

### Login Test Accounts
Use any registered patient email to login:
- john.doe@email.com
- jane.smith@email.com
- mike.johnson@email.com

### Test Scenarios
1. Register new patient ✅
2. Search and filter doctors ✅
3. Book appointment ✅
4. View appointment history ✅
5. Cancel appointment ✅
6. Logout ✅

## Notes

- All timestamps are in UTC
- Phone numbers stored as strings
- Allergies support multi-select
- Available time slots must match doctor's schedule
- Doctor availability is validated during appointment booking
- Deleted appointments cannot be recovered (soft delete recommended for production)

## Future Enhancements

- [ ] Doctor rating and review system
- [ ] Push notifications for appointments
- [ ] Payment integration
- [ ] Prescription refills
- [ ] Patient medical records
- [ ] Admin dashboard
- [ ] Doctor app version
- [ ] SMS/Email notifications

---

**Created by: Student ID 2251172547**
**Date: December 27, 2025**
