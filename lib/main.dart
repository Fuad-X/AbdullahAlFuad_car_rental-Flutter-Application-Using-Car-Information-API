import 'package:flutter/material.dart';
import 'pages/reservation/reservation_details.dart';
import 'pages/reservation/reservation_form.dart';
import 'pages/reservation/customer_information.dart';
import 'pages/reservation/vehicle_information.dart';
import 'pages/reservation/additional_charges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuad Car Rental',
      initialRoute: '/reservation/form',
      routes: {
        '/reservation/customer/information': (context) => const CustomerInformationPage(),
        '/reservation/form': (context) => const ReservationFormPage(),
        '/reservation/details': (context) => const ReservationDetailsPage(),
        '/reservation/vehicle/information': (context) => const VehicleInformationPage(),
        '/reservation/additional/charges': (context) => const AdditionalChargesPage(),
      },
    );
  }
}
