import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_rent_app/pages/reservation/reservation_form.dart';
import 'package:car_rent_app/pages/reuse_ables/outer_label_bordered_input_field.dart';
import 'package:car_rent_app/pages/classes/user_information_class.dart';

class CustomerInformationPage extends StatefulWidget {
  const CustomerInformationPage({super.key});

  @override
  _CustomerInformationPageState createState() => _CustomerInformationPageState();
}

class _CustomerInformationPageState extends State<CustomerInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  double get margin => MediaQuery.of(context).size.width * 0.05;

  Widget _buildFormFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputField(
            labelText: "First Name",
            controller: _firstNameController,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First Name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            labelText: "Last Name",
            controller: _lastNameController,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Last Name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            labelText: "Email",
            controller: _emailController,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!value.contains('@') || !value.contains('.')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInputField(
            labelText: "Phone",
            controller: _phoneController,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone number is required';
              }
              if (value.length != 11) {
                return 'Phone number must be 11 digits long';
              }
              if (!value.startsWith('0')) {
                return 'Phone number must start with 0';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //print(arguments['details'].id);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Customer Information",
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
                  child: _buildFormFields(),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final userInfo = UserInformationClass(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                    );
                    arguments['userInfo'] = userInfo;
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.pushNamed(
                          context,
                          '/reservation/vehicle/information',
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
}