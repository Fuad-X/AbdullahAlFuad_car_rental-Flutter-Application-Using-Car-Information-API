import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_rent_app/pages/classes/additional_charges_class.dart';

class AdditionalChargesPage extends StatefulWidget {
  const AdditionalChargesPage({super.key});

  @override
  _AdditionalChargesPageState createState() => _AdditionalChargesPageState();
}

class _AdditionalChargesPageState extends State<AdditionalChargesPage> {
  bool _collisionDamageWaiver = false;
  bool _liabilityInsurance = false;
  bool _rentalTax = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //print(arguments['details'].id);
    //print(arguments['userInfo'].firstName);
    //print(arguments['vehicleInfo'].type);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Vehicle Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Divider(color: Colors.blue, thickness: 1.0),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: CupertinoColors.inactiveGray),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child:Column(
                children: [
                  CheckboxListTile(
                    value: _collisionDamageWaiver,
                    onChanged: (bool? value) {
                      setState(() {
                        _collisionDamageWaiver = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading, // Move checkbox to the left
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Collision Damage Waiver'), // Left-aligned text
                        Text(
                          '\$9.00',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.grey),
                        ), // Right-aligned text
                      ],
                    ),
                  ),
                  CheckboxListTile(
                    value: _liabilityInsurance,
                    onChanged: (bool? value) {
                      setState(() {
                        _liabilityInsurance = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading, // Move checkbox to the left
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Liability Insurance'), // Left-aligned text
                        Text(
                          '\$15.00',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.grey),
                        ), // Right-aligned text
                      ],
                    ),
                  ),
                  CheckboxListTile(
                    value: _rentalTax,
                    onChanged: (bool? value) {
                      setState(() {
                        _rentalTax = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading, // Move checkbox to the left
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Rental Tax'),
                        Text(
                          '11.50%',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final charges = AdditionalChargesClass(
                    damage: _collisionDamageWaiver,
                    insurance: _liabilityInsurance,
                    tax: _rentalTax,
                  );
                  arguments['charges'] = charges;
                  Navigator.pushNamed(
                    context,
                    '/reservation/details',
                    arguments: arguments,
                  );
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
    );
  }
}