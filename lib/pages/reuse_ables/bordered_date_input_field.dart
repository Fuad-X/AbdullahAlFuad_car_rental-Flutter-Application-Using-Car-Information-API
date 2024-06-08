import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateInputField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final ValueChanged<DateTime?>? onChanged;
  final bool isRequired;

  const CustomDateInputField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.onChanged,
    this.isRequired = false,
  }) : super(key: key);

  Future<void> _selectDateTime(BuildContext context) async {
    // Show date picker first
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      // Show time picker after date is selected
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Format the combined date and time in 12-hour format with AM/PM
        controller.text = DateFormat('yyyy-MM-dd hh:mm a').format(combinedDateTime);
        onChanged?.call(combinedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: labelText,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              if (isRequired)
                const TextSpan(
                  text: '*',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.inactiveGray),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.calendar_today),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
            ),
            readOnly: true,
            onTap: () => _selectDateTime(context),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select pickup date and time'; // Localize this message
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}