import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/doctor/presentation/view_model/doctor_bloc.dart';
import 'package:myasteer/features/doctor/presentation/view_model/doctor_state.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctors List')),
      body: BlocBuilder<DoctorBloc, DoctorState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }
          if (state.doctors.isEmpty) {
            return const Center(child: Text('No Doctors Available'));
          }
          return ListView.builder(
            itemCount: state.doctors.length,
            itemBuilder: (context, index) {
              final doctor = state.doctors[index];

              return ListTile(
                title: Text(doctor.name),
                subtitle: Text(doctor.contact ?? 'No contact info'),
                leading: const Icon(Icons.person),
              );
            },
          );
        },
      ),
    );
  }
}
