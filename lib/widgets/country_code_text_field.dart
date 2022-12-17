import 'package:flutter/material.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

class CountryCodeTextField extends StatelessWidget {
  const CountryCodeTextField({
    super.key,
    required this.code,
    this.onChange,
  });
  final CountryCode code;
  final void Function()? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onChange,
      readOnly: true,
      controller: TextEditingController(text: code.dialCode),
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        suffix: code.flagImage,
        labelText: "Country Code",
      ),
    );
  }
}
