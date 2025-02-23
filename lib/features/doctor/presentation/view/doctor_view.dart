import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/doctor/presentation/view_model/doctor_bloc.dart';
import 'package:myasteer/features/doctor/presentation/view_model/doctor_state.dart';

class DoctorView extends StatefulWidget {
  const DoctorView({super.key});

  @override
  State<DoctorView> createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  String? selectedSpecialization;

  // ✅ Ensure a valid image URL is returned
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

          // Extract specializations dynamically while handling `null` values
          List<String> specializations = state.doctors
              .map((doctor) => doctor.specialization ?? "General")
              .toSet()
              .toList();

          specializations.insert(0, "All");

          // ✅ Filter doctors based on selected category
          List doctorsToShow =
              selectedSpecialization == null || selectedSpecialization == "All"
                  ? state.doctors
                  : state.doctors
                      .where((doctor) =>
                          doctor.specialization == selectedSpecialization)
                      .toList();

          return Column(
            children: [
              const SizedBox(height: 12),

              // ✅ Doctor List with Clickable Pop-up
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemCount: doctorsToShow.length,
                    itemBuilder: (context, index) {
                      final doctor = doctorsToShow[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              getImageUrl(doctor.image),
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.network(
                                      "https://via.placeholder.com/150",
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover),
                            ),
                          ),
                          title: Text(
                            doctor.name ?? "Unknown Doctor",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            doctor.specialization ?? "General",
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              _showDoctorPopup(doctor);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text("View",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // 📌 Show Popup for Doctor Details
  void _showDoctorPopup(dynamic doctor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, // Left align text
            children: [
              // 📷 Doctor Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    getImageUrl(doctor.image),
                    width: 220,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.network(
                        "https://via.placeholder.com/150",
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // 📖 Doctor Details
              Text(
                doctor.name ?? "Unknown Doctor",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                doctor.specialization ?? "General Practitioner",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue),
              ),
              const SizedBox(height: 5),
              Text(
                "Contact: ${doctor.contact ?? "No contact available"}",
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 5),
              Text(
                "Email: ${doctor.email ?? "No email provided"}",
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 20),

              // 🛒 Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement Booking functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      minimumSize: const Size(120, 40),
                    ),
                    child: const Text(
                      "Book Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(120, 40),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
