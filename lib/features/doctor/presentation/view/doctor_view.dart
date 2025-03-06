import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myAster/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myAster/features/doctor/presentation/view_model/doctor_bloc.dart';
import 'package:myAster/features/doctor/presentation/view_model/doctor_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorView extends StatefulWidget {
  const DoctorView({super.key});

  @override
  State<DoctorView> createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  String? userId;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');
    final name = prefs.getString('userName');

    if (id != null && id.isNotEmpty) {
      setState(() {
        userId = id;
        userName = name ?? "Unknown";
      });
    }
  }

  String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.trim().isEmpty) {
      return "https://via.placeholder.com/150";
    }
    if (imagePath.contains("192.168.1.88")) {
      return imagePath.replaceFirst("192.168.1.88", "127.0.0.1");
    }
    return imagePath.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Find the Best Doctors',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: BlocBuilder<DoctorBloc, DoctorState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(
              child: Text(
                'Error: ${state.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          if (state.doctors.isEmpty) {
            return const Center(
              child: Text(
                'No Doctors Available',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: state.doctors.length,
            itemBuilder: (context, index) {
              final DoctorEntity doctor = state.doctors[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      getImageUrl(doctor.image),
                      width: 65,
                      height: 65,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.network("https://via.placeholder.com/150",
                              width: 65, height: 65, fit: BoxFit.cover),
                    ),
                  ),
                  title: Text(
                    doctor.name ?? "Unknown Doctor",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    doctor.specialization ?? "General",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _showBookingForm(doctor);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Book Now",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showBookingForm(DoctorEntity doctor) {
    final TextEditingController ageController = TextEditingController();
    final TextEditingController problemController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    String selectedGender = "Male";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Book an Appointment"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration("Your Age"),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: _inputDecoration("Select Gender"),
                  items: ["Male", "Female", "Other"]
                      .map((gender) =>
                          DropdownMenuItem(value: gender, child: Text(gender)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dateController,
                  decoration: _inputDecoration("Appointment Date"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      dateController.text =
                          DateFormat('yyyy-MM-dd').format(picked);
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: timeController,
                  decoration: _inputDecoration("Appointment Time"),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      timeController.text = picked.format(context);
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: problemController,
                  decoration: _inputDecoration("Describe Your Problem"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back"),
            ),
            ElevatedButton(
              onPressed: () {
                _scheduleAppointment(
                    doctor.id ?? "", // ✅ Ensures it is always a String
                    ageController.text,
                    selectedGender,
                    problemController.text,
                    dateController.text,
                    timeController.text);
              },
              child: const Text("Confirm Booking"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _scheduleAppointment(String doctorId, String age, String gender,
      String problemDescription, String date, String time) async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("User not logged in"), backgroundColor: Colors.red),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.88:5003/appointments/schedule"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "doctorId": doctorId,
          "age": age,
          "gender": gender,
          "problemDescription": problemDescription,
          "date": date,
          "time": time,
        }),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Appointment booked successfully!")),
      );
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${error.toString()}")),
      );
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      labelText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
