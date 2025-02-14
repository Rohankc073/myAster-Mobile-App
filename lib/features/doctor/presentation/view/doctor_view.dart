import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/doctor/presentation/view_model/bloc/doctor_bloc.dart';

class DoctorView extends StatelessWidget {
  DoctorView({super.key});

  final _doctorFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final specializationController = TextEditingController();
  final availableDaysController = TextEditingController();
  final availableTimesController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Doctor')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _doctorFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(nameController, 'Doctor Name'),
              _buildTextField(specializationController, 'Specialization'),
              _buildTextField(availableDaysController, 'Available Days'),
              _buildTextField(availableTimesController, 'Available Times'),
              _buildTextField(contactController, 'Contact',
                  keyboardType: TextInputType.phone),
              _buildTextField(emailController, 'Email',
                  keyboardType: TextInputType.emailAddress),

              const SizedBox(height: 20),

              // Add Doctor Button
              BlocConsumer<DoctorBloc, DoctorState>(
                listener: (context, state) {
                  if (!state.isLoading && state.error == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Doctor added successfully')),
                    );
                    _clearForm();
                  } else
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')),
                    );
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () {
                            if (_doctorFormKey.currentState!.validate()) {
                              context.read<DoctorBloc>().add(
                                    CreateDoctor(
                                      name: nameController.text,
                                      specialization:
                                          specializationController.text,
                                      availableDays:
                                          availableDaysController.text,
                                      availableTimes:
                                          availableTimesController.text,
                                      contact: contactController.text,
                                      email: emailController.text,
                                    ),
                                  );
                            }
                          },
                    child: state.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Add Doctor'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for TextFormField
  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  // Clear form fields after adding doctor
  void _clearForm() {
    nameController.clear();
    specializationController.clear();
    availableDaysController.clear();
    availableTimesController.clear();
    contactController.clear();
    emailController.clear();
  }
}
