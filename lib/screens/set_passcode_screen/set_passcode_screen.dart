import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/utils/passcode_utils.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class SetPasscodeScreen extends StatefulWidget {
  const SetPasscodeScreen({super.key});

  static const routeName = "/set-passcode-screen";

  @override
  State<SetPasscodeScreen> createState() => _SetPasscodeScreenState();
}

class _SetPasscodeScreenState extends State<SetPasscodeScreen> {
  final TextEditingController pinController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              const ScreenNameSection(label: "Set passcode"),
              const SizedBox(height: 20),
              Pinput(
                onCompleted: _onSetPasscode,
                length: 6,
                controller: pinController,
              )
            ]),
          ),
        ),
      ),
    );
  }

  _onSetPasscode(String pin) async {
    await PasscodeUtils().savePasscode(passcode: pin);
    if (!mounted) return;
    Navigator.pop(context);
    // Navigator.pop(context);
  }
}
