import 'package:flutter/material.dart';
import 'package:myasteer/view/bottom_screen/appointment_screen.dart';
import 'package:myasteer/view/bottom_screen/profile_screen.dart';

import '../features/home/presentation/view/bottom_view/dashboard_view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  // Define the screens for the bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const AppointmentScreen(),
    const ProfileScreen(),
  ];

  // Define AppBar titles for each screen
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]), // Dynamic AppBar title
        centerTitle: true,
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

// Dummy Home Screen


// Dummy Appointment Screen



