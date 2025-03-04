import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myAster/app/di/di.dart';
import 'package:myAster/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:myAster/features/home/presentation/view/bottom_view/profile_view.dart';
import 'package:myAster/features/home/presentation/view/bottom_view/setting_view.dart';
import 'package:myAster/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:myAster/features/product/presentation/view/product_view.dart';
import 'package:myAster/features/product/presentation/view_model/product_bloc.dart';
import 'package:myAster/sensor/promixity_sensor.dart';
import 'package:myAster/sensor/shake_detector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  late ShakeDetector _shakeDetector;
  late ProximityDetector _proximityDetector;
  bool _isScreenOff = false; // ✅ Controls screen visibility

  final List<String> _appBarTitles = [
    "Home",
    "Products",
    "Profile",
    "Settings",
  ];

  @override
  void initState() {
    super.initState();

    // ✅ Initialize ShakeDetector
    _shakeDetector = ShakeDetector(
      onPhoneShake: _logout, // ✅ Calls logout when phone shakes
    );

    _shakeDetector.startListening(); // ✅ Start shake detection

    // ✅ Initialize ProximityDetector
    _proximityDetector = ProximityDetector(
      onProximityChange: (bool isNear) {
        setState(() {
          _isScreenOff = isNear;
        });
      },
    );

    _proximityDetector.startListening(); // ✅ Start proximity detection
  }

  @override
  void dispose() {
    _shakeDetector.stopListening(); // ✅ Stop shake detection
    _proximityDetector.stopListening(); // ✅ Stop proximity detection
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ✅ Logout Function
  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');

    print("User logged out due to shake gesture!");

    // Navigate back to login screen
    context.read<HomeCubit>().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isScreenOff
          ? Colors.black
          : Colors.white, // ✅ Turn screen black if near
      body: _isScreenOff
          ? const Center(
              child: Text("Screen Off",
                  style: TextStyle(color: Colors.white, fontSize: 24)))
          : IndexedStack(
              index: _selectedIndex,
              children: [
                const HomeScreen(),
                BlocProvider(
                  create: (context) => getIt<ProductBloc>(),
                  child: const ProductView(),
                ),
                const ProfileScreen(),
                const SettingsScreen(),
              ],
            ),
      bottomNavigationBar: _isScreenOff
          ? null // ✅ Hide bottom navigation if screen is off
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'Products',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
    );
  }
}
