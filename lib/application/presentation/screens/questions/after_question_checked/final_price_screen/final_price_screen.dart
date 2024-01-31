import 'package:beachdu/application/presentation/screens/navbar/bottombar.dart';
import 'package:beachdu/application/presentation/screens/pickup/pickup_screen.dart';
import 'package:beachdu/application/presentation/screens/questions/after_question_checked/final_price_screen/final_product_container.dart';
import 'package:beachdu/application/presentation/screens/questions/after_question_checked/final_price_screen/final_product_price_details.dart';
import 'package:beachdu/application/presentation/utils/constants.dart';
import 'package:beachdu/application/presentation/utils/exit_app_daillogue/exit_app_dailogue.dart';
import 'package:beachdu/application/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class FinalPriceScreen extends StatelessWidget {
  const FinalPriceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode focusScopeNode = FocusScope.of(context);
        if (!focusScopeNode.hasPrimaryFocus) {
          focusScopeNode.unfocus();
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: sHeight * .76,
                  child: const Column(
                    children: [
                      FinalProductContiner(),
                      FinalProductPriceDetaails(),
                      PrivacyPolicyCheckbox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicyCheckbox extends StatefulWidget {
  const PrivacyPolicyCheckbox({super.key});

  @override
  _PrivacyPolicyCheckboxState createState() => _PrivacyPolicyCheckboxState();
}

class _PrivacyPolicyCheckboxState extends State<PrivacyPolicyCheckbox> {
  bool isPrivacyPolicyAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: isPrivacyPolicyAccepted,
                onChanged: (value) {
                  setState(() {
                    isPrivacyPolicyAccepted = value ?? false;
                  });
                },
              ),
              kWidth10,
              const Text(
                'By signing up I agree to the \nTerms of use and Privacy Policy.',
              ),
            ],
          ),
          kHeight30,
          ElevatedButtonLong(
            wdth: 200,
            onPressed: () {
              if (isPrivacyPolicyAccepted) {
                body[1] = const ScreenPickUp();
                bottomBarNotifier.notifyListeners();
              } else {
                showConfirmationDialog(
                  context,
                  heading: 'Please accept Privacy Policies',
                  textButtonNo: true,
                );
              }
            },
            text: 'Continue to Details',
          ),
        ],
      ),
    );
  }
}
