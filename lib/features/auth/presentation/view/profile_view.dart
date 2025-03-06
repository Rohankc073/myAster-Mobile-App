import 'package:flutter/material.dart';
import 'package:myAster/features/auth/presentation/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _logout(BuildContext context) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove('token'); // ✅ Completely remove the token
    await sharedPreferences.clear(); // ✅ Clear all stored data (optional)

    if (!context.mounted)
      return; // ✅ Ensure context is still valid before navigation

    // ✅ Use `pushAndRemoveUntil` to prevent returning to the previous screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
      (route) => false, // Removes all previous routes
    );
  }

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
            IconButton(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout, color: Colors.black),
            ),
            const Text(
              "Rohan KC",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "rohan7@gmail.com",
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
              subtitle: const Text("+977 9000000000"),
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
              onPressed: () async {
                await _logout(context); // ✅ Call logout function
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Log Out",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
