import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/doctor/presentation/view_model/doctor_bloc.dart';
import 'package:myasteer/features/doctor/presentation/view_model/doctor_state.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.trim().isEmpty) {
      return "https://via.placeholder.com/150"; // Placeholder image
    }
    if (imagePath.contains("localhost")) {
      return imagePath.replaceFirst("localhost", "127.0.0.1");
    }
    return imagePath.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors List',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<DoctorBloc, DoctorState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(
                child: Text('Error: ${state.error}',
                    style: const TextStyle(color: Colors.red, fontSize: 16)));
          }
          if (state.doctors.isEmpty) {
            return const Center(
                child: Text('No Doctors Available',
                    style: TextStyle(fontSize: 18)));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: state.doctors.length,
              itemBuilder: (context, index) {
                final doctor = state.doctors[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(getImageUrl(doctor.image)),
                      radius: 30,
                      onBackgroundImageError: (_, __) {
                        const AssetImage('assets/default_avatar.png');
                      },
                    ),
                    title: Text(
                      doctor.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   doctor.specialization,
                        //   style: const TextStyle(
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w500,
                        //       color: Colors.blue),
                        // ),
                        Text(
                          doctor.contact ?? 'No contact info',
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.blueAccent),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
