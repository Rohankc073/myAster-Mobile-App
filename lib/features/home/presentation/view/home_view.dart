import 'package:flutter/material.dart';
import 'package:myasteer/features/auth/presentation/view/login_page.dart';
import 'package:myasteer/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:myasteer/view/bottom_screen/appointment_screen.dart';
import 'package:myasteer/view/bottom_screen/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AppointmentScreen(),
    const ProfileScreen(),
  ];

  final List<String> _appBarTitles = [
    "Home",
    "Appointments",
    "Profile",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Logout Function
  Future<void> _logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Remove token
    await prefs.remove('user'); // Remove user data

    print("User logged out successfully!");

    // Navigate back to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context); // Call Logout Function
            },
            tooltip: "Logout",
          ),
        ],
      ),
      body: _screens[_selectedIndex], // Dynamic screen based on selection
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
