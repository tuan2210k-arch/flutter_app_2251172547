import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String patientCollection = 'patients';
  static const String doctorCollection = 'doctors';
  static const String appointmentCollection = 'appointments';

  FirebaseFirestore get firestore => _firestore;

  CollectionReference getCollection(String collectionName) {
    return _firestore.collection(collectionName);
  }

  DocumentReference getDocument(String collectionName, String docId) {
    return _firestore.collection(collectionName).doc(docId);
  }
}
