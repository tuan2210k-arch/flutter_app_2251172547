import 'package:flutter/material.dart';
import '../models/doctor_model.dart';
import '../repositories/appointment_repository.dart';
import 'appointment_booking_screen.dart';

class DoctorDetailScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorDetailScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Detail - 2251172547'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue,
                      child: Text(
                        doctor.fullName[0],
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      doctor.fullName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      doctor.specialization,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Information Sections
            _buildInfoSection('Qualification', doctor.qualification),
            _buildInfoSection('Experience', '${doctor.experience} years'),
            _buildInfoSection('Phone', doctor.phoneNumber),
            _buildInfoSection('Email', doctor.email),
            _buildInfoSection(
              'Rating',
              '${doctor.rating} / 5.0',
            ),
            _buildInfoSection(
              'Consultation Fee',
              '\$${doctor.consultationFee.toStringAsFixed(2)}',
            ),

            const SizedBox(height: 24),
            const Text(
              'Working Days',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: doctor.availableDays.map((day) {
                return Chip(label: Text(day));
              }).toList(),
            ),

            const SizedBox(height: 24),
            const Text(
              'Available Time Slots',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: doctor.availableTimeSlots.map((time) {
                return Chip(label: Text(time));
              }).toList(),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AppointmentBookingScreen(doctor: doctor),
                      settings: RouteSettings(
                        arguments: ModalRoute.of(context)
                            ?.settings
                            .arguments,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
