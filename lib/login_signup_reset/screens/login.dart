import 'package:flutter/material.dart';
import 'package:gsgflutter/login_signup_reset/screens/reset_password.dart';
import 'package:gsgflutter/login_signup_reset/screens/signup.dart';
import 'package:gsgflutter/login_signup_reset/widgets/login_form.dart';
import 'package:gsgflutter/login_signup_reset/widgets/primary_button.dart';
import 'package:gsgflutter/login_signup_reset/widgets/theme.dart';

class LogInScreen extends StatelessWidget {
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
                  'Login',
                  style: titleText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Text(
                      'New to this app?',
                      style: subTitle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: textButton.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              LogInForm(),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen()));
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: kZambeziColor,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: PrimaryButton(
                  buttonText: 'Log In',
                ),
              )
              // Text(
              //   'Or log in with:',
              //   style: subTitle.copyWith(color: kBlackColor),
              // ),
              // LoginOption(),
            ],
          ),
        ),
      ),
    ));
  }
}
