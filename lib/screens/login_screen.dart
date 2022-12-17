import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

import '../helper/firebase_helper.dart';
import '../widgets/country_code_text_field.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CountryCode code = const CountryCode(name: "US", code: "US", dialCode: "+1");
  final TextEditingController phoneNumberController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/img/logo.png",
                  height: 200,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "What is your phone number",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Tap next to get SMS confirmation",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CountryCodeTextField(
                        code: code,
                        onChange: () async {
                          code = (await const FlCountryCodePicker()
                                  .showPicker(context: context)) ??
                              code;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          hintText: "Enter your phone number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (phoneNumberController.text.isNotEmpty) {
                            loading = true;
                            setState(() {});
                            FireBaseHelper.verifyPhoneNumber(code.dialCode +
                                    phoneNumberController.text.trim())
                                .then((value) {
                              loading = false;

                              setState(() {});
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OTPScreen(
                                            phoneNumber: code.dialCode +
                                                phoneNumberController.text
                                                    .trim(),
                                          )));
                            });
                          }
                        },
                        child: const Text("Next"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
