import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/patient_model.dart';
import '../repositories/patient_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  
  DateTime? _dateOfBirth;
  String? _selectedGender;
  String? _selectedBloodType;
  Set<String> _selectedAllergies = {};
  bool _isLoading = false;

  final PatientRepository _patientRepository = PatientRepository();

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _bloodTypes = ['A', 'B', 'AB', 'O'];
  final List<String> _allergiesList = [
    'Penicillin',
    'Aspirin',
    'Iodine',
    'Shellfish',
    'Peanuts',
    'Sulfonamides',
    'Latex'
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  void _registerAccount() async {
    if (_formKey.currentState!.validate()) {
      if (_dateOfBirth == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select date of birth')),
        );
        return;
      }
      if (_selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select gender')),
        );
        return;
      }

      setState(() => _isLoading = true);

      try {
        final exists =
            await _patientRepository.emailExists(_emailController.text);
        if (exists) {
          throw Exception('Email already registered');
        }

        final patientId = const Uuid().v4();
        final patient = PatientModel(
          patientId: patientId,
          email: _emailController.text.trim(),
          fullName: _nameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          dateOfBirth: Timestamp.fromDate(_dateOfBirth!),
          gender: _selectedGender!,
          address: _addressController.text.trim(),
          bloodType: _selectedBloodType,
          allergies: _selectedAllergies.toList(),
          emergencyContact: _emergencyContactController.text.trim(),
          createdAt: Timestamp.now(),
        );

        await _patientRepository.addPatient(patient);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up - 2251172547"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_emailController, "Email", Icons.email, true),
              _buildTextField(_nameController, "Full Name", Icons.person, false),
              _buildTextField(
                  _phoneController, "Phone Number", Icons.phone, false),
              _buildTextField(
                  _addressController, "Address", Icons.home, false),
              _buildTextField(_emergencyContactController,
                  "Emergency Contact", Icons.phone_in_talk, false),
              const SizedBox(height: 15),
              Material(
                child: InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorationTextField(
                    label: _dateOfBirth == null
                        ? 'Date of Birth'
                        : DateFormat('yyyy-MM-dd').format(_dateOfBirth!),
                    icon: Icons.calendar_today,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: const Icon(Icons.wc),
                  border: const OutlineInputBorder(),
                ),
                items: _genders.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedGender = value);
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedBloodType,
                decoration: InputDecoration(
                  labelText: 'Blood Type (Optional)',
                  prefixIcon: const Icon(Icons.bloodtype),
                  border: const OutlineInputBorder(),
                ),
                items: _bloodTypes.map((bloodType) {
                  return DropdownMenuItem(
                    value: bloodType,
                    child: Text(bloodType),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedBloodType = value);
                },
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Allergies (Select all that apply)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _allergiesList.map((allergy) {
                  return FilterChip(
                    label: Text(allergy),
                    selected: _selectedAllergies.contains(allergy),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedAllergies.add(allergy);
                        } else {
                          _selectedAllergies.remove(allergy);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _isLoading ? null : _registerAccount,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text("SIGN UP",
                        style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      IconData icon, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) return "This field is required";
          if (isEmail && !val.contains('@')) return "Invalid email format";
          return null;
        },
      ),
    );
  }
}

class InputDecorationTextField extends StatelessWidget {
  final String label;
  final IconData icon;

  const InputDecorationTextField({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      child: Text(label),
    );
  }
}
