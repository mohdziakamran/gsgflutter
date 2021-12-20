import 'package:flutter/material.dart';
import 'package:gsgflutter/backend/api_backend.dart';
import 'package:gsgflutter/login_signup_reset/screens/login.dart';
import 'package:gsgflutter/login_signup_reset/widgets/primary_button.dart';
import 'package:gsgflutter/login_signup_reset/widgets/reset_form.dart';
import 'package:gsgflutter/theme.dart';
import 'package:gsgflutter/mylib/my_lib.dart';
import 'package:validators/validators.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key? key, required this.emailController})
      : super(key: key);
  TextEditingController emailController;

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
                    child: ResetForm(
                      emailController: widget.emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: PrimaryButton(
                      buttonText: 'Reset Password',
                      ontapaction: resetPasswordAction,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void resetPasswordAction() {
    String email = widget.emailController.text;
    if (email.isEmpty || !isEmail(email)) {
      MyLib.mySnackbar(context, "Invalid Email");
    }

    ///api call
    ApiBackend.forgotPasswordRequest();

    ///if sucess to login
    Navigator.pop(context);
  }
}
