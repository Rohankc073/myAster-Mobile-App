import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  String? userId;
  List orders = [];
  List appointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');

    if (userId != null) {
      await _fetchOrders();
      await _fetchAppointments();
    }
  }

  Future<void> _fetchOrders() async {
    try {
      final response =
          await http.get(Uri.parse("http://localhost:5003/order/user/$userId"));

      if (response.statusCode == 200) {
        setState(() {
          orders = jsonDecode(response.body);
        });
      }
    } catch (error) {
      print("Error fetching orders: $error");
    }
  }

  Future<void> _fetchAppointments() async {
    try {
      final response = await http.get(Uri.parse(
          "http://localhost:5003/appointments/getAll?userId=$userId"));

      if (response.statusCode == 200) {
        setState(() {
          appointments = jsonDecode(response.body);
          isLoading = false;
        });
      }
    } catch (error) {
      print("Error fetching appointments: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders & Appointments")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Appointments Section
                  const Text("Appointments",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  appointments.isNotEmpty
                      ? Column(
                          children: appointments
                              .map((appointment) => Card(
                                    elevation: 3,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/doctor.png"),
                                      ),
                                      title: Text(
                                          "Dr. ${appointment['doctorName']}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Date: ${appointment['date']}"),
                                          Text("Time: ${appointment['time']}"),
                                        ],
                                      ),
                                      trailing: Text(appointment['status'],
                                          style: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ))
                              .toList(),
                        )
                      : const Text("No appointments found.",
                          style: TextStyle(fontSize: 16)),

                  const SizedBox(height: 20),

                  // ✅ Orders Section
                  const Text("Orders",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  orders.isNotEmpty
                      ? Column(
                          children: orders
                              .map((order) => Card(
                                    elevation: 3,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                              "Order ID: ${order['_id']}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          subtitle: Text(
                                              "Status: ${order['status']}"),
                                        ),
                                        ...order['items']
                                            .map<Widget>((item) => ListTile(
                                                  leading: Image.network(
                                                    item['productId']
                                                            ['image'] ??
                                                        "https://via.placeholder.com/80",
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  title: Text(item['productId']
                                                          ['name'] ??
                                                      "Unknown Product"),
                                                  subtitle: Text(
                                                      "Price: NPR ${item['price']}"),
                                                  trailing: Text(
                                                      "Qty: ${item['quantity']}"),
                                                )),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        )
                      : const Text("No orders found.",
                          style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
    );
  }
}
