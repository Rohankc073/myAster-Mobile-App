import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myAster/features/history/history_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
      userName = prefs.getString('userName');
      userEmail = prefs.getString('userEmail');
      userPhone = prefs.getString('userPhone') ?? "Not Set";
      isLoading = false;
    });
  }

  Future<void> _updateUserProfile(
      String updatedName, String updatedPhone) async {
    if (userId == null) return;

    try {
      final response = await http.put(
        Uri.parse("http://localhost:5003/user/update/$userId"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": updatedName, "contact": updatedPhone}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', updatedName);
        await prefs.setString('userPhone', updatedPhone);

        setState(() {
          userName = updatedName;
          userPhone = updatedPhone;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(responseData["message"] ?? "Profile updated!")),
        );
      } else {
        throw Exception(responseData["error"] ?? "Failed to update profile");
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${error.toString()}")),
      );
    }
  }

  void _showEditDialog(
      String title, String fieldValue, Function(String) onSave) {
    final TextEditingController controller =
        TextEditingController(text: fieldValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $title"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "Enter new $title"),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/dummy.jpg'),
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userName ?? "User",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userEmail ?? "No Email",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text("Phone Number"),
                    subtitle: Text(userPhone ?? "Not Set"),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog("Phone Number", userPhone ?? "",
                            (newPhone) {
                          _updateUserProfile(userName ?? "", newPhone);
                        });
                      },
                    ),
                  ),
                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Full Name"),
                    subtitle: Text(userName ?? "Not Set"),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog("Full Name", userName ?? "", (newName) {
                          _updateUserProfile(newName, userPhone ?? "");
                        });
                      },
                    ),
                  ),
                  const Divider(),

                  // ✅ New Navigation Item (My Orders & Appointments)
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text("My Orders & Appointments"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyOrdersScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
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
