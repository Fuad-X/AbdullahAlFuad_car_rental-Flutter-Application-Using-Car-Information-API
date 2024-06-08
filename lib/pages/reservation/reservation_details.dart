import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationDetailsPage extends StatefulWidget {
  const ReservationDetailsPage({super.key});
  @override
  _ReservationDetailsPageState createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage>{
  Map<String, dynamic> arguments = {};
  late double weeks;
  late double weeklyTotal;
  late double days;
  late double dailyTotal;
  late double hours;
  late double hourlyTotal;
  late double total;
  late double tax;
  late double discount;

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    weeks = double.parse(arguments['details'].weeks);
    weeklyTotal = double.parse(arguments['vehicleInfo'].weeklyRate) * weeks;
    days = double.parse(arguments['details'].days);
    dailyTotal = double.parse(arguments['vehicleInfo'].dailyRate) * days;
    hours = double.parse(arguments['details'].hours);
    hourlyTotal = double.parse(arguments['vehicleInfo'].hourlyRate) * hours;
    total = weeklyTotal + dailyTotal + hourlyTotal;

    if(arguments['charges'].tax) {
      tax = total * .115;
      total += tax;
    }
    if(arguments['charges'].damage) total += 9;
    if(arguments['charges'].insurance) total += 15;
    if(arguments['details'].discount == "FUAD2024"){
      discount = total*0.15;
      total -= discount;
    }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Back'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                "Reservation Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Divider(color: Colors.blue, thickness: 1.0),
              const SizedBox(height: 16),
              buildReservationDetailsSection(),
              const SizedBox(height: 48),
              const Text(
                "Customer Information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Divider(color: Colors.blue, thickness: 1.0),
              const SizedBox(height: 16),
              buildUserInfoSection(),
              const SizedBox(height: 48),
              const Text(
                "Vehicle Information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Divider(color: Colors.blue, thickness: 1.0),
              const SizedBox(height: 16),
              buildVehicleInfoSection(),
              const SizedBox(height: 48),
              const Text(
                "Charges Summary",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Divider(color: Colors.blue, thickness: 1.0),
              const SizedBox(height: 16),
              buildChargesSummarySection(),
            ],
          ),
        ),
      );
    }


  Widget buildReservationDetailsSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.inactiveGray),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Reservation ID'),
                Text(arguments['details'].id, textAlign: TextAlign.right,),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pickup Date'),
                Text(DateFormat('hh.mm a, dd MMMM, yyyy').format(DateTime.parse(arguments['details'].pickupDate)), textAlign: TextAlign.right,),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dropoff Date'),
                Text(DateFormat('hh.mm a, dd MMMM, yyyy').format(DateTime.parse(arguments['details'].returnDate)), textAlign: TextAlign.right,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserInfoSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.inactiveGray),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('First name'),
                Text(arguments['userInfo'].firstName, textAlign: TextAlign.right,),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Last name'),
                Text(arguments['userInfo'].lastName, textAlign: TextAlign.right,),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Email'),
                Text(arguments['userInfo'].email, textAlign: TextAlign.right,),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Phone'),
                Text(arguments['userInfo'].phone, textAlign: TextAlign.right,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVehicleInfoSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.inactiveGray),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Vehicle Type'),
                Text(arguments['vehicleInfo'].type, textAlign: TextAlign.right,),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Vehicle Model'),
                Text(arguments['vehicleInfo'].model, textAlign: TextAlign.right,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChargesSummarySection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 253, 255),
        border: Border.all(color: CupertinoColors.inactiveGray),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Charge', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Total',style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right,),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.blue, thickness: 1.0),
            if(weeks > 0) const SizedBox(height: 6),
            if(weeks > 0) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Weekly ($weeks ${weeks == 1 ? 'week' : 'weeks'})"),
                Text('\$${weeklyTotal.toStringAsFixed(2)}' , textAlign: TextAlign.right,),
              ],
            ),
            if(days > 0) const SizedBox(height: 16),
            if(days > 0) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Daily ($days ${days == 1 ? 'day' : 'days'})"),
                Text('\$${dailyTotal.toStringAsFixed(2)}' , textAlign: TextAlign.right,),
              ],
            ),
            if(hours > 0) const SizedBox(height: 16),
            if(hours > 0) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hourly ($hours ${hours == 1 ? 'hour' : 'hours'})"),
                Text('\$${hourlyTotal.toStringAsFixed(2)}' , textAlign: TextAlign.right,),
              ],
            ),
            if(arguments['charges'].damage) const SizedBox(height: 16),
            if(arguments['charges'].damage) const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Collision Damage Waiver'),
                Text('\$9.00', textAlign: TextAlign.right,),
              ],
            ),
            if(arguments['charges'].insurance) const SizedBox(height: 16),
            if(arguments['charges'].insurance) const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Liability Insurance'),
                Text('\$15.00', textAlign: TextAlign.right,),
              ],
            ),
            if(arguments['charges'].tax) const SizedBox(height: 16),
            if(arguments['charges'].tax) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Rental Tax"),
                Text('\$${tax.toStringAsFixed(2)}' , textAlign: TextAlign.right,),
              ],
            ),
            if(arguments['details'].discount == "FUAD2024") const SizedBox(height: 16),
            if(arguments['details'].discount == "FUAD2024") Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Discount(15.00%)"),
                Text('\$${discount.toStringAsFixed(2)}' , textAlign: TextAlign.right,),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Net Total',style: TextStyle(fontWeight: FontWeight.bold),),
                Text('\$${total.toStringAsFixed(2)}', textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChargeItem(String title, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            amount,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}