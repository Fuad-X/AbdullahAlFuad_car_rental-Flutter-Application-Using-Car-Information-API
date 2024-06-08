import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:car_rent_app/pages/classes/vehicle_information_class.dart';

class VehicleInformationPage extends StatefulWidget {
  const VehicleInformationPage({super.key});

  @override
  _VehicleInformationState createState() => _VehicleInformationState();
}

class _VehicleInformationState extends State<VehicleInformationPage> {
  String apiUrl = "https://exam-server-7c41747804bf.herokuapp.com/carsList";
  List vehicles = [];
  List vehiclesToShow = [];
  List<String> types = [];
  String? selectedType;
  double margin = 0.0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchVehicle();
  }

  Future<void> fetchVehicle() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message'] == "Cars fetched successfully.") {
          vehicles = data['data'] as List;
          Set<String> temp = {};
          for (var vehicle in vehicles) {
            temp.add(vehicle['type']);
          }
          setState(() {
            types = temp.toList();
            if (types.isNotEmpty) {
              selectedType = types.first; // Initialize selectedType with the first type
              filterVehicles(selectedType!);
            }
          });
        }
      } else {
        throw Exception('Failed to load vehicles');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching vehicle data: $error');
      }
    }
  }

  void filterVehicles(String type) {
    setState(() {
      vehiclesToShow = vehicles.where((vehicle) => vehicle['type'] == type).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //print(arguments['details'].id);
    //print(arguments['userInfo'].firstName);
    margin = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Back'),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              child: Padding(
                  padding: EdgeInsets.all(margin),
                  child: Form(
                    key: _formKey,
                    child: Column(
                    children: [
                      buildVehicleTypeDropdown(),
                      const SizedBox(height: 20),
                      buildVehicleModelTextField(),
                      const SizedBox(height: 20),
                      ],
                    ),
                  ),
              ),
            ),
            if (vehiclesToShow.isNotEmpty) ...vehiclesToShow.map((vehicle) => buildVehicleInfoCard(vehicle)),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false && vehiclesToShow != null) {
                      final vehicleInfo = VehicleInformationClass(
                          type: vehiclesToShow[0]['type'].toString(),
                          model: vehiclesToShow[0]['model'].toString(),
                          dailyRate: vehiclesToShow[0]['rates']['daily'].toString(),
                          weeklyRate: vehiclesToShow[0]['rates']['weekly'].toString(),
                          hourlyRate: vehiclesToShow[0]['rates']['hourly'].toString(),
                      );
                      arguments['vehicleInfo'] = vehicleInfo;
                      Navigator.pushNamed(
                          context,
                          '/reservation/additional/charges',
                          arguments: arguments,
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

  Widget buildVehicleTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Vehicle Type",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedType,
          onChanged: (value) {
            if (value != null) {
              filterVehicles(value);
              setState(() {
                selectedType = value;
              });
            }
          },
          items: types.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null) {
              return 'Please select a vehicle type';
            }
            return null;
          },
        ),
      ],
    );
  }
  Widget buildVehicleModelTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Vehicle Type",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _searchController,
          onChanged: (value) {
            filterVehiclesByModel(value);
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.search),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a vehicle model';
            }
            return null;
          },
        )
      ],
    );
  }

  void filterVehiclesByModel(String query) {
    if (query.isEmpty) {
      setState(() {
        vehiclesToShow = vehicles.where((vehicle) => vehicle['type'] == selectedType).toList();
      });
      return;
    }
    setState(() {
      vehiclesToShow = vehicles.where((vehicle) => vehicle['type'] == selectedType && vehicle['model'].toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  Widget buildVehicleInfoCard(vehicle) {
    return Padding(
      padding: EdgeInsets.only(top: margin),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.inactiveGray),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(margin),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Image.network(
                        vehicle['imageURL'],
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(margin),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vehicle['make'] + " " + vehicle['model'] ?? 'Unknown',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 4),
                                Text('${vehicle['seats'] ?? 0} seat(s)'),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.luggage),
                                const SizedBox(width: 4),
                                Text('${vehicle['bags'] ?? 0} bag(s)'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: CupertinoColors.inactiveGray, thickness: 1.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: margin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${vehicle['rates']['hourly'] ?? 0} / Hour'),
                    Text('\$${vehicle['rates']["daily"] ?? 0} / Day'),
                    Text('\$${vehicle['rates']["weekly"] ?? 0} / Week'),
                  ],
                ),
              ),
          ]
        ),
      ),
    );
  }
}