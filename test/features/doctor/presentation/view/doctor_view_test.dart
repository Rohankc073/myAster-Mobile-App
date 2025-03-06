// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:myAster/features/doctor/domain/entity/doctor_entity.dart';
// import 'package:myAster/features/doctor/presentation/view/doctor_view.dart';
// import 'package:myAster/features/doctor/presentation/view_model/doctor_bloc.dart';
// import 'package:myAster/features/doctor/presentation/view_model/doctor_state.dart';

// // ✅ Mocking DoctorBloc
// class MockDoctorBloc extends Mock implements DoctorBloc {}

// void main() {
//   late MockDoctorBloc mockDoctorBloc;

//   setUp(() {
//     mockDoctorBloc = MockDoctorBloc();
//   });

//   Widget createWidgetUnderTest() {
//     return MaterialApp(
//       home: BlocProvider<DoctorBloc>.value(
//         value: mockDoctorBloc,
//         child: const DoctorView(),
//       ),
//     );
//   }

//   group('🧪 DoctorView Widget Tests', () {
//     testWidgets('✅ Displays loading indicator when isLoading is true',
//         (WidgetTester tester) async {
//       when(() => mockDoctorBloc.state).thenReturn(
//         const DoctorState(
//           doctors: [],
//           isLoading: true,
//           isImageLoading: false,
//           isImageSuccess: false,
//         ),
//       );

//       await tester.pumpWidget(createWidgetUnderTest());

//       expect(find.byType(CircularProgressIndicator), findsOneWidget);
//     });

//     testWidgets('❌ Displays error message when an error occurs',
//         (WidgetTester tester) async {
//       when(() => mockDoctorBloc.state).thenReturn(
//         const DoctorState(
//           doctors: [],
//           isLoading: false,
//           error: 'Failed to load doctors',
//           isImageLoading: false,
//           isImageSuccess: false,
//         ),
//       );

//       await tester.pumpWidget(createWidgetUnderTest());

//       expect(find.text('Error: Failed to load doctors'), findsOneWidget);
//     });

//     testWidgets('✅ Displays doctor list when data is available',
//         (WidgetTester tester) async {
//       final testDoctors = [
//         const DoctorEntity(
//           id: "1",
//           name: "Dr. John Doe",
//           specialization: "Cardiologist",
//           image: "https://via.placeholder.com/150",
//         ),
//         const DoctorEntity(
//           id: "2",
//           name: "Dr. Jane Smith",
//           specialization: "Dermatologist",
//           image: "https://via.placeholder.com/150",
//         ),
//       ];

//       when(() => mockDoctorBloc.state).thenReturn(
//         DoctorState(
//           doctors: testDoctors,
//           isLoading: false,
//           isImageLoading: false,
//           isImageSuccess: false,
//         ),
//       );

//       await tester.pumpWidget(createWidgetUnderTest());
//       await tester.pumpAndSettle(); // ✅ Ensures widget tree updates

//       expect(find.text("Dr. John Doe"), findsOneWidget);
//       expect(find.text("Dr. Jane Smith"), findsOneWidget);
//       expect(find.text("Cardiologist"), findsOneWidget);
//       expect(find.text("Dermatologist"), findsOneWidget);
//     });

//     testWidgets('🛠 Clicking "Book Now" opens booking dialog',
//         (WidgetTester tester) async {
//       final testDoctors = [
//         const DoctorEntity(
//           id: "1",
//           name: "Dr. John Doe",
//           specialization: "Cardiologist",
//           image: "https://via.placeholder.com/150",
//         ),
//       ];

//       when(() => mockDoctorBloc.state).thenReturn(
//         DoctorState(
//           doctors: testDoctors,
//           isLoading: false,
//           isImageLoading: false,
//           isImageSuccess: false,
//         ),
//       );

//       await tester.pumpWidget(createWidgetUnderTest());
//       await tester.pumpAndSettle();

//       expect(find.text("Dr. John Doe"), findsOneWidget);

//       // Tap the "Book Now" button
//       await tester.tap(find.text("Book Now"));
//       await tester.pumpAndSettle();

//       // Verify that the booking form opens
//       expect(find.text("Book an Appointment"), findsOneWidget);
//     });
//   });
// }
