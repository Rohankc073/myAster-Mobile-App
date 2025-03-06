// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myasteer/features/user/presentation/view_model/user_bloc.dart';
// import 'package:myasteer/features/user/presentation/view_model/user_state.dart';

// class UserView extends StatefulWidget {
//   const UserView({super.key});

//   @override
//   State<UserView> createState() => _UserViewState();
// }

// class _UserViewState extends State<UserView> {
//   String? selectedSpecialization;

//   String getImageUrl(String? imagePath) {
//     if (imagePath == null || imagePath.trim().isEmpty) {
//       return "https://via.placeholder.com/150"; // Placeholder image
//     }
//     if (imagePath.contains("192.168.1.88")) {
//       return imagePath.replaceFirst("192.168.1.88", "127.0.0.1");
//     }
//     return imagePath.trim();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100], // Light background for a clean UI
//       appBar: AppBar(
//         title: const Text(
//           'Find the Best Users',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//         elevation: 0,
//       ),
//       body: BlocBuilder<UserBloc, UserState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state.error != null) {
//             return Center(
//                 child: Text(
//               'Error: ${state.error}',
//               style: const TextStyle(color: Colors.red, fontSize: 16),
//             ));
//           }
//           if (state.users.isEmpty) {
//             return const Center(
//                 child: Text(
//               'No Users Available',
//               style: TextStyle(fontSize: 18),
//             ));
//           }

//           // Extract specializations dynamically
//           List<String> specializations = state.users
//               .map((user) => user.specialization ?? "General")
//               .toSet()
//               .toList();

//           // Ensure "All" is the first category
//           specializations.insert(0, "All");

//           // Filter users based on selected category
//           List usersToShow = selectedSpecialization == null ||
//                   selectedSpecialization == "All"
//               ? state.users
//               : state.users
//                   .where(
//                       (user) => user.specialization == selectedSpecialization)
//                   .toList();

//           return Column(
//             children: [
//               // Top Section with Modern Banner
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.blueAccent, Colors.lightBlue],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: const Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(Icons.health_and_safety,
//                         color: Colors.white, size: 40),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Find Your Specialist",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "Book an appointment with top users",
//                             style:
//                                 TextStyle(fontSize: 14, color: Colors.white70),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // Specialization Categories with modern UI
//               SizedBox(
//                 height: 50,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: specializations.length,
//                   itemBuilder: (context, index) {
//                     String specialization = specializations[index];
//                     bool isSelected =
//                         specialization == selectedSpecialization ||
//                             (selectedSpecialization == null &&
//                                 specialization == "All");

//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedSpecialization =
//                               isSelected ? "All" : specialization;
//                         });
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 10),
//                         margin: const EdgeInsets.symmetric(horizontal: 5),
//                         decoration: BoxDecoration(
//                           color: isSelected ? Colors.blueAccent : Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                               color: isSelected
//                                   ? Colors.blueAccent
//                                   : Colors.grey[300]!),
//                           boxShadow: isSelected
//                               ? [
//                                   BoxShadow(
//                                       color: Colors.blueAccent.withOpacity(0.2),
//                                       blurRadius: 5,
//                                       spreadRadius: 1)
//                                 ]
//                               : [],
//                         ),
//                         child: Text(
//                           specialization,
//                           style: TextStyle(
//                               color:
//                                   isSelected ? Colors.white : Colors.blueAccent,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // User List
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: ListView.builder(
//                     itemCount: usersToShow.length,
//                     itemBuilder: (context, index) {
//                       final user = usersToShow[index];
//                       return Card(
//                         elevation: 2,
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 8, horizontal: 8),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(12),
//                           leading: ClipRRect(
//                             borderRadius: BorderRadius.circular(50),
//                             child: Image.network(
//                               getImageUrl(user.image),
//                               width: 55,
//                               height: 55,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) =>
//                                   Image.network(
//                                       "https://via.placeholder.com/150",
//                                       width: 55,
//                                       height: 55,
//                                       fit: BoxFit.cover),
//                             ),
//                           ),
//                           title: Text(
//                             user.name,
//                             style: const TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 user.specialization ?? "General",
//                                 style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.blue),
//                               ),
//                               Text(
//                                 user.contact ?? 'No contact info',
//                                 style: const TextStyle(
//                                     fontSize: 14, color: Colors.grey),
//                               ),
//                               Text(
//                                 user.email ?? 'No email provided',
//                                 style: const TextStyle(
//                                     fontSize: 14, color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                           trailing: ElevatedButton(
//                             onPressed: () {
//                               // Implement booking functionality
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                             ),
//                             child: const Text("Book",
//                                 style: TextStyle(color: Colors.white)),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
