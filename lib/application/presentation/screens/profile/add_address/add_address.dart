import 'package:beachdu/application/presentation/screens/navbar/bottombar.dart';
import 'package:beachdu/application/presentation/screens/pickup/widgets/textfeild_custom.dart';
import 'package:beachdu/application/presentation/screens/profile/profile_screen.dart';
import 'package:beachdu/application/presentation/utils/constants.dart';
import 'package:beachdu/application/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode focusScopeNode = FocusScope.of(context);
        if (!focusScopeNode.hasPrimaryFocus) {
          focusScopeNode.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          profileScreensNotifier.value = 0;
          profileScreensNotifier.notifyListeners();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 120,
            leading: IconButton(
              onPressed: () {
                profileScreensNotifier.value = 0;
                profileScreensNotifier.notifyListeners();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 16,
              ),
            ),
            title: Text(
              'Create address',
              style: textHeadSemiBold1,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STATE',
                        style: textHeadMedium1.copyWith(
                          fontSize: sWidth * .033,
                        ),
                      ),
                      const TTextFormField(
                        text: 'Kerala',
                      ),
                      Text(
                        'DISTRICT',
                        style: textHeadMedium1.copyWith(
                          fontSize: sWidth * .033,
                        ),
                      ),
                      const TTextFormField(
                        text: 'Wayanad',
                      ),
                      Text(
                        'LANDMARK',
                        style: textHeadMedium1.copyWith(
                          fontSize: sWidth * .033,
                        ),
                      ),
                      const TTextFormField(
                        text: 'School',
                      ),
                      Text(
                        'PINCODE',
                        style: textHeadMedium1.copyWith(
                          fontSize: sWidth * .033,
                        ),
                      ),
                      const TTextFormField(
                        text: 'xxxxxx',
                      ),
                    ],
                  ),
                ),
                kHeight30,
                ElevatedButtonLong(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState!.save();
                    }
                  },
                  text: 'Save',
                ),
                kHeight40
              ],
            ),
          ),
        ),
      ),
    );
  }
}
