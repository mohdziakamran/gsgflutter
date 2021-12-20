import 'package:flutter/material.dart';
import 'package:gsgflutter/login_signup_reset/screens/login.dart';
import 'package:gsgflutter/login_signup_reset/widgets/primary_button.dart';
import 'package:gsgflutter/login_signup_reset/widgets/reset_form.dart';
import 'package:gsgflutter/login_signup_reset/widgets/theme.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: kDefaultPadding,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Reset Password',
                      style: titleText,
                    ),
                  ),
                  Text(
                    'Please enter your email address',
                    style: subTitle.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: ResetForm(),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogInScreen(),
                            ));
                      },
                      child: PrimaryButton(buttonText: 'Reset Password')),
                ],
              ),
            )),
      ),
    );
  }
}
