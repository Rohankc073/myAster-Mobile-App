import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myAster/features/cart/presentation/view/cart_screen_view.dart';
import 'package:myAster/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:myAster/features/home/presentation/view/bottom_view/profile_view.dart';
import 'package:myAster/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:myAster/features/product/presentation/view/product_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import the Cart Page

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ProductView(),
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
    context.read<HomeCubit>().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        centerTitle: true,
        actions: [
          // 🛒 Cart Button
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            tooltip: "Cart",
          ),

          // 🔑 Logout Button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context);
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
