import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_rent_app/pages/reuse_ables/outer_label_bordered_input_field.dart';
import 'package:car_rent_app/pages/reuse_ables/bordered_date_input_field.dart';
import 'package:intl/intl.dart';
import 'package:car_rent_app/pages/classes/reservation_details_class.dart';

class ReservationFormPage extends StatefulWidget {
  const ReservationFormPage({super.key});

  @override
  _ReservationFormPageState createState() => _ReservationFormPageState();
}

class _ReservationFormPageState extends State<ReservationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _reservationIdController = TextEditingController();
  final TextEditingController _pickupDateController = TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  late DateTime pickupDate;
  late DateTime returnDate;
  late int hours;
  late int days;
  late int weeks;

  void _calculateDuration() {
    if (_pickupDateController.text.isNotEmpty && _returnDateController.text.isNotEmpty) {
      pickupDate = DateFormat('yyyy-MM-dd hh:mm a').parse(_pickupDateController.text);
      returnDate = DateFormat('yyyy-MM-dd hh:mm a').parse(_returnDateController.text);

      Duration duration = returnDate.difference(pickupDate);

      if (duration.isNegative) {
        _durationController.text = 'Invalid date selection';
      } else {
        int totalDays = duration.inDays;
        hours = duration.inHours % 24;
        int remainingMinutes = duration.inMinutes % 60;

        weeks = totalDays ~/ 7;
        days = totalDays % 7;

        String durationString = '';
        if (weeks > 0) {
          durationString += '$weeks Week${weeks != 1 ? 's' : ''} ';
        }
        if (days > 0) {
          durationString += '$days Day${days != 1 ? 's' : ''} ';
        }
        if (hours > 0) {
          durationString += '$hours Hour${hours != 1 ? 's' : ''} ';
        }
        if (remainingMinutes > 0) {
          durationString += '$remainingMinutes Minute${remainingMinutes != 1 ? 's' : ''}';
        }

        _durationController.text = durationString.trim();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double margin = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40),
              const Text(
                "Reservation Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Divider(color: Colors.blue, thickness: 1.0),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.inactiveGray),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(margin),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInputField(
                          labelText: "Reservation ID",
                          controller: _reservationIdController,
                          isRequired: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Reservation ID is required';
                            }
                            int? intValue = int.tryParse(value);
                            if (intValue == null || intValue <= 0) {
                              return 'Please enter a valid Reservation ID';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomDateInputField(
                          labelText: "Pickup Date",
                          controller: _pickupDateController,
                          onChanged: (value) => _calculateDuration(),
                          isRequired: true,
                        ),
                        const SizedBox(height: 20),
                        CustomDateInputField(
                          labelText: "Leave Date",
                          controller: _returnDateController,
                          onChanged: (value) => _calculateDuration(),
                          isRequired: true,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  "Duration",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            const Spacer(flex: 1),
                            Expanded(
                              flex: 7,
                              child: CustomInputField(
                                controller: _durationController,
                                readonly: true,
                                validator: (value) {
                                  if (value == "Invalid date selection" || (hours <= 0 && days <= 0 && weeks <= 0)) {
                                    return "Please select a valid time";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        CustomInputField(
                          labelText: "Discount",
                          controller: _discountController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final details = ReservationDetailsClass(
                        id: _reservationIdController.text,
                        hours: hours.toString(),
                        days: days.toString(),
                        weeks: weeks.toString(),
                        pickupDate: pickupDate.toString(),
                        returnDate: returnDate.toString(),
                        discount: _discountController.text,
                    );
                    final Map<String, dynamic> dataMap = {
                      'details' : details,
                    };
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.pushNamed(
                        context,
                        '/reservation/customer/information',
                        arguments: dataMap,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
