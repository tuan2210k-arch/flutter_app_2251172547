# Firebase Setup Guide for Clinic Management App

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click "Create a new project"
3. Name it: `clinic-management-2251172547`
4. Accept terms and create project
5. Wait for project initialization

## Step 2: Create Firestore Database

1. In Firebase Console, click "Cloud Firestore"
2. Click "Create database"
3. Choose region (e.g., us-central1)
4. Select "Start in production mode"
5. Click "Create"

## Step 3: Configure Collections in Firestore

Create three collections:

### Create "patients" Collection
1. Click "Start collection"
2. Collection ID: `patients`
3. Click "Next"
4. Add a test patient document manually or use Firebase Admin SDK

### Create "doctors" Collection
1. Repeat steps 1-3
2. Collection ID: `doctors`

### Create "appointments" Collection
1. Repeat steps 1-3
2. Collection ID: `appointments`

## Step 4: Get Firebase Configuration

1. In Firebase Console, go to Project Settings (gear icon)
2. Look for your web app config
3. Copy the following values:

```javascript
const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "your-project.firebaseapp.com",
  projectId: "clinic-management-2251172547",
  storageBucket: "your-project.appspot.com",
  messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
  appId: "YOUR_APP_ID"
};
```

## Step 5: Update firebase_options.dart

Replace the placeholder values in `lib/firebase_options.dart` with your actual Firebase credentials:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_API_KEY',
  appId: '1:YOUR_ID:web:YOUR_ID',
  messagingSenderId: 'YOUR_MESSAGING_ID',
  projectId: 'clinic-management-2251172547',
  authDomain: 'clinic-management-2251172547.firebaseapp.com',
  databaseURL: 'https://clinic-management-2251172547.firebaseio.com',
  storageBucket: 'clinic-management-2251172547.appspot.com',
);
```

## Step 6: Configure Android (if needed)

1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/`
3. Ensure `google-services.json` is included in `.gitignore`

## Step 7: Configure iOS (if needed)

1. Download `GoogleService-Info.plist` from Firebase Console
2. Add to iOS project in Xcode under "Runner"
3. Ensure it's included in target "Runner"

## Step 8: Set Firestore Security Rules

1. Go to Firestore → Rules
2. Replace with these development rules:

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow patients to read/write their own documents
    match /patients/{document=**} {
      allow read, write;
    }
    
    // Allow read for doctors
    match /doctors/{document=**} {
      allow read;
    }
    
    // Allow read/write for appointments
    match /appointments/{document=**} {
      allow read, write;
    }
  }
}
```

**⚠️ WARNING**: These are permissive rules for development. For production, implement proper authentication and authorization.

## Step 9: Run the App

```bash
flutter pub get
flutter run
```

## Adding Sample Data

### Option 1: Firebase Console

1. Go to Firestore Collections
2. Click "Add document"
3. Set document ID and add fields manually

### Option 2: Dart Code

Run this in your app or in a separate admin script:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

Future<void> addSampleData() async {
  final db = FirebaseFirestore.instance;
  
  // Add sample doctor
  await db.collection('doctors').doc('doctor_1').set({
    'doctorId': 'doctor_1',
    'email': 'dr.alice@clinic.com',
    'fullName': 'Dr. Alice Green',
    'phoneNumber': '+1111111111',
    'specialization': 'Cardiology',
    'qualification': 'MD, Cardiology',
    'experience': 10,
    'consultationFee': 100.0,
    'availableDays': ['Monday', 'Wednesday', 'Friday'],
    'availableTimeSlots': ['09:00', '10:00', '14:00', '15:00'],
    'rating': 4.8,
    'isActive': true,
    'createdAt': Timestamp.now(),
  });
  
  // Add sample patient
  await db.collection('patients').doc('patient_1').set({
    'patientId': 'patient_1',
    'email': 'john.doe@email.com',
    'fullName': 'John Doe',
    'phoneNumber': '+1234567890',
    'dateOfBirth': Timestamp.fromDate(DateTime(1990, 5, 15)),
    'gender': 'male',
    'address': '123 Main St',
    'bloodType': 'O',
    'allergies': ['Penicillin', 'Aspirin'],
    'emergencyContact': '+1234567800',
    'createdAt': Timestamp.now(),
  });
}
```

## Troubleshooting

### Issue: "MissingPluginException"
- Solution: Run `flutter pub get` and rebuild

### Issue: Firestore connection fails
- Check internet connection
- Verify Firebase project is created
- Check Firestore database is enabled
- Verify firebase_options.dart has correct credentials

### Issue: Permission denied error
- Update Firestore security rules (see Step 8)
- Check your user has proper permissions

### Issue: App won't run
- Delete `build/` directory: `flutter clean`
- Rebuild: `flutter pub get && flutter run`

## Next Steps

1. Add sample data using Firebase Console
2. Test login with sample patient email
3. Browse doctors and book appointments
4. Check Firestore in real-time for updates
5. Deploy to Firebase Hosting (optional)

## Firebase Admin SDK (for server operations)

If you need backend operations, consider adding:

```bash
npm install -g firebase-tools
firebase init
```

Then create cloud functions for:
- Payment processing
- Email notifications
- Complex validations
- Data migration

---

**More Help**: [Firebase Documentation](https://firebase.google.com/docs)
