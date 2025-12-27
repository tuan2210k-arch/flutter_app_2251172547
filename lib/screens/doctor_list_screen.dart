import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/doctor_model.dart';
import '../repositories/doctor_repository.dart';
import 'doctor_detail_screen.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({Key? key}) : super(key: key);

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final DoctorRepository _doctorRepository = DoctorRepository();
  final _searchController = TextEditingController();
  String? _selectedSpecialization;
  List<String> _specializations = [];

  @override
  void initState() {
    super.initState();
    _loadSpecializations();
  }

  void _loadSpecializations() async {
    try {
      final specs = await _doctorRepository.getAllSpecializations();
      setState(() => _specializations = specs);
    } catch (e) {
      print('Error loading specializations: $e');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors - 2251172547'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search doctors...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 12),
                DropdownButton<String?>(
                  value: _selectedSpecialization,
                  hint: const Text('Filter by Specialization'),
                  isExpanded: true,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All Specializations'),
                    ),
                    ..._specializations.map((spec) {
                      return DropdownMenuItem(
                        value: spec,
                        child: Text(spec),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedSpecialization = value);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<DoctorModel>>(
              stream: _doctorRepository.getAllDoctorsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No doctors found'));
                }

                var doctors = snapshot.data!;

                if (_searchController.text.isNotEmpty) {
                  doctors = doctors
                      .where((doctor) =>
                          doctor.fullName.toLowerCase().contains(
                              _searchController.text.toLowerCase()) ||
                          doctor.specialization.toLowerCase().contains(
                              _searchController.text.toLowerCase()))
                      .toList();
                }

                if (_selectedSpecialization != null) {
                  doctors = doctors
                      .where((doctor) =>
                          doctor.specialization == _selectedSpecialization)
                      .toList();
                }

                return ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return _buildDoctorCard(context, doctor);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(BuildContext context, DoctorModel doctor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(doctor.fullName[0]),
        ),
        title: Text(
          doctor.fullName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doctor.specialization),
            Text('Experience: ${doctor.experience} years'),
            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                Text(' ${doctor.rating}'),
                const SizedBox(width: 16),
                Text('Fee: \$${doctor.consultationFee.toStringAsFixed(2)}'),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetailScreen(
                doctor: doctor,
              ),
            ),
          );
        },
      ),
    );
  }
}
