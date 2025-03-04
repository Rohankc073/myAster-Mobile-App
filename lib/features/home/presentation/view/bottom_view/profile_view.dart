import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                  'assets/images/dummy.jpg'), // Replace with your image
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              "Rohan KC",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "rohan073@gmail.com",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Phone Number"),
              subtitle: const Text("+977 9827904325"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Add functionality to edit phone number
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Address"),
              subtitle: const Text("Softwarica, Dilibazar"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Add functionality to edit address
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text("Date of Birth"),
              subtitle: const Text("1st Jan, 2025"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Add functionality to edit date of birth
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality for logout
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logged out")),
                );
              },
              child: const Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
