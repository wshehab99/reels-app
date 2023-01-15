import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:reels_app/presentation/resources/color_manger.dart';
import 'package:reels_app/presentation/resources/size_manger.dart';
import 'package:reels_app/presentation/resources/string_manger.dart';

import '../../helper/firebase_helper.dart';
import '../home/home_screen.dart';
import '../resources/assets_manger.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    this.phoneNumber,
  });
  final String? phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  CountryCode code = const CountryCode(name: "US", code: "US", dialCode: "+1");
  final TextEditingController phoneNumberController = TextEditingController();
  String _code = "";
  bool _onEditing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                AssetsManager.logo,
                height: SizesManger.s200,
              )),
              const SizedBox(
                height: SizesManger.s25,
              ),
              const Text(
                StringManger.verifyPhoneNumber,
                style: TextStyle(
                  fontSize: SizesManger.s26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: SizesManger.s10,
              ),
              Text(
                "${StringManger.checkYourSMSmessages} ${widget.phoneNumber}",
                style: const TextStyle(
                  fontSize: SizesManger.s15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: SizesManger.s20,
              ),
              Center(
                child: VerificationCode(
                  textStyle: const TextStyle(
                      fontSize: SizesManger.s20, color: ColorManger.darkBlue),
                  keyboardType: TextInputType.number,
                  underlineColor: ColorManger
                      .amber, // If this is null it will use primaryColor: Colors.red from Theme
                  length: SizesManger.s6,
                  cursorColor: ColorManger
                      .blue, // If this is null it will default to the ambient
                  // clearAll is NOT required, you can delete it
                  // takes any widget, so you can implement your design
                  clearAll: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      StringManger.clearAll,
                      style: TextStyle(
                          fontSize: SizesManger.s15,
                          decoration: TextDecoration.underline,
                          color: ColorManger.darkBlue),
                    ),
                  ),
                  onCompleted: (String value) {
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () async {
                        await FireBaseHelper.resendOTP(widget.phoneNumber!);
                      },
                      child: const Text(StringManger.resendOTP)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    FireBaseHelper.confirm(_code).then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    });
                  },
                  child: const Text(StringManger.verify),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
