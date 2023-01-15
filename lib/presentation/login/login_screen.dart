import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:reels_app/presentation/resources/assets_manger.dart';
import 'package:reels_app/presentation/resources/size_manger.dart';
import 'package:reels_app/presentation/resources/string_manger.dart';

import '../../helper/firebase_helper.dart';
import '../common/widgets/country_code_text_field.dart';
import '../otp/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CountryCode code = const CountryCode(
      name: StringManger.us,
      code: StringManger.us,
      dialCode: StringManger.usCode);
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
                  AssetsManager.logo,
                  height: SizesManger.s200,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  StringManger.yourPhoneNumber,
                  style: TextStyle(
                    fontSize: SizesManger.s26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: SizesManger.s10,
                ),
                const Text(
                  StringManger.getSMSconfirmation,
                  style: TextStyle(
                    fontSize: SizesManger.s15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: SizesManger.s20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: SizesManger.s1,
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
                          labelText: StringManger.phoneNumber,
                          hintText: StringManger.phoneNumberHint,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(SizesManger.s25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: SizesManger.s25,
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
                        child: const Text(StringManger.next))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
