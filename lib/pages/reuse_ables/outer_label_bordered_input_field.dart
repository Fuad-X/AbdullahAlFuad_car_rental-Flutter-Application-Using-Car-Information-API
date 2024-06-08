import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? labelText;
  final String? hint;
  final TextEditingController controller;
  final bool readonly;
  final bool isRequired;
  final FormFieldValidator<String>? validator;

  const CustomInputField({
    super.key,
    this.labelText,
    this.hint,
    required this.controller,
    this.readonly = false,
    this.isRequired = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null && labelText!.isNotEmpty)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: labelText,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
              ],
            ),
          ),
        if (labelText != null && labelText!.isNotEmpty)
          const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.inactiveGray),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextFormField(
            controller: controller,
            readOnly: readonly,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
