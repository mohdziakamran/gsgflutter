import 'package:flutter/material.dart';
import 'package:gsgflutter/login_signup_reset/widgets/checkbox.dart';
import 'package:gsgflutter/login_signup_reset/widgets/login_option.dart';
import 'package:gsgflutter/login_signup_reset/widgets/primary_button.dart';
import 'package:gsgflutter/login_signup_reset/widgets/signup_form.dart';
import 'package:gsgflutter/login_signup_reset/widgets/theme.dart';

import 'login.dart';

class SignUpScreen extends StatelessWidget {
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
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Create Account',
                style: titleText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Text(
                    'Already a member?',
                    style: subTitle,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()));
                    },
                    child: Text(
                      'Log In',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SignUpForm(),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: CheckBox('Agree to terms and conditions.'),
            ),
            // const Padding(
            //   child: CheckBox('I have at least 18 years old.'),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: PrimaryButton(buttonText: 'Sign Up'),
            ),
            // Padding(
            //   padding: kDefaultPadding,
            //   child: Text(
            //     'Or log in with:',
            //     style: subTitle.copyWith(color: kBlackColor),
            //   ),
            // ),
            // Padding(
            //   padding: kDefaultPadding,
            //   child: LoginOption(),
            // ),
          ],
        ),
      ),
    )));
  }
}
