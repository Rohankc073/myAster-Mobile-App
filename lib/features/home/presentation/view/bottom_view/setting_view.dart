import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
            subtitle: Text("Manage notifications settings"),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("Privacy"),
            subtitle: Text("Manage privacy settings"),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            subtitle: Text("Change app language"),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Help & Support"),
            subtitle: Text("Get assistance with the app"),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
          ),
        ],
      ),
    );
  }
}
