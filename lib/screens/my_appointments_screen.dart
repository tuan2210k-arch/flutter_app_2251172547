import 'package:flutter/material.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';
import '../repositories/appointment_repository.dart';
import '../repositories/doctor_repository.dart';
import 'appointment_detail_screen.dart';

class MyAppointmentsScreen extends StatefulWidget {
  final String patientId;

  const MyAppointmentsScreen({Key? key, required this.patientId})
      : super(key: key);

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  final AppointmentRepository _appointmentRepository =
      AppointmentRepository();
  final DoctorRepository _doctorRepository = DoctorRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments - 2251172547'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<AppointmentModel>>(
        stream: _appointmentRepository.getAppointmentsByPatientStream(widget.patientId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error loading appointments'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => setState(() {}),
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No appointments found'),
                ],
              ),
            );
          }

          // Sort by date descending
          final appointments = snapshot.data!;
          appointments.sort((a, b) => b.appointmentDate.compareTo(a.appointmentDate));

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              return _buildAppointmentCard(context, appointments[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildAppointmentCard(
      BuildContext context, AppointmentModel appointment) {
    return FutureBuilder<DoctorModel?>(
      future: _doctorRepository.getDoctorById(appointment.doctorId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final doctor = snapshot.data!;
        final appointmentDateTime = appointment.appointmentDate.toDate();
        final statusColor = _getStatusColor(appointment.status);

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
                Text(
                  '${appointmentDateTime.toString().substring(0, 10)} at ${appointment.appointmentTime}',
                ),
                Text(doctor.specialization),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                appointment.status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentDetailScreen(
                    appointment: appointment,
                    doctor: doctor,
                    patientId: widget.patientId,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'scheduled':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'no_show':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
