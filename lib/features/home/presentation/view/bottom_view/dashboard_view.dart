import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myAster/app/di/di.dart';
import 'package:myAster/core/common/snackbar/my_snackbar.dart';
import 'package:myAster/features/doctor/presentation/view/doctor_view.dart';
import 'package:myAster/features/doctor/presentation/view_model/doctor_bloc.dart';
import 'package:myAster/features/product/presentation/view/product_view.dart';
import 'package:myAster/features/product/presentation/view_model/product_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Good Afternoon",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
            const SizedBox(height: 5),
            // const Text(
            //   "Guest",
            //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search Doctors/Specialities",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("See All",
                    style: TextStyle(fontSize: 16, color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: const [
                CategoryItem(
                    icon: Icons.medical_services,
                    label: "Dentistry",
                    color: Colors.pinkAccent),
                CategoryItem(
                    icon: Icons.favorite,
                    label: "Cardiology",
                    color: Colors.green),
                CategoryItem(
                    icon: Icons.lan,
                    label: "Pulmonology",
                    color: Colors.orange),
                CategoryItem(
                    icon: Icons.stop, label: "General", color: Colors.purple),
                CategoryItem(
                    icon: Icons.people, label: "Neurology", color: Colors.teal),
                CategoryItem(
                    icon: Icons.lunch_dining,
                    label: "Gastro",
                    color: Colors.deepPurple),
                CategoryItem(
                    icon: Icons.science, label: "Lab", color: Colors.redAccent),
                CategoryItem(
                    icon: Icons.local_pharmacy,
                    label: "Pharmacy",
                    color: Colors.blueAccent),
              ],
            ),
            const SizedBox(height: 20),
            _buildDoctorBookingSection(context),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ActionCard(
                    title: "Book your Services",
                    subtitle: "24x7",
                    icon: Icons.support_agent,
                    backgroundColor: Colors.pinkAccent,
                    buttonLabel: "Book",
                    onPressed: () {
                      showMySnackBar(
                          context: context, message: "Booking Service...");
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ActionCard(
                    title: "Pharmacy",
                    subtitle: "Medicine at your doorstep",
                    icon: Icons.local_pharmacy,
                    backgroundColor: Colors.lightBlue,
                    buttonLabel: "Buy",
                    onPressed: () {
                      showMySnackBar(
                          context: context, message: "Navigating to Products");
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  getIt<ProductBloc>()..add(LoadProducts()),
                              child: const ProductView(),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorBookingSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/doctor.png',
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 80, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Online and Offline Consultations",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    showMySnackBar(context: context, message: "Doctors Viewed");
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) =>
                                getIt<DoctorBloc>()..add(LoadDoctors()),
                            child: const DoctorView(),
                          ),
                        ),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white, // Button text is white
                  ),
                  child: const Text("Book Now"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, size: 30, color: color),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center),
      ],
    );
  }
}

class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final String buttonLabel;
  final VoidCallback? onPressed;

  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.buttonLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 40, color: backgroundColor),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Text(subtitle,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: onPressed ?? () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: Colors.white, // Button text is now white
              ),
              child: Text(buttonLabel),
            ),
          ),
        ],
      ),
    );
  }
}
