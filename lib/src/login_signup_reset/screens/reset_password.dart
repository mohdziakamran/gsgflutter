import 'package:flutter/material.dart';
import 'package:gsgflutter/src/login_signup_reset/widgets/primary_button.dart';
import 'package:gsgflutter/src/login_signup_reset/widgets/reset_form.dart';
import 'package:gsgflutter/src/utility/backend/api_backend.dart';
import 'package:gsgflutter/src/utility/my_lib.dart';
import 'package:gsgflutter/src/utility/theme.dart';
import 'package:validators/validators.dart';

import '../../../MyException.dart';

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

  Future<void> resetPasswordAction() async {
    String email = widget.emailController.text;
    if (email.isEmpty || !isEmail(email)) {
      MyLib.mySnackbar(context, "Invalid Email");
      return;
    }
    String response = "";

    ///-->///if all check pass Make API Call
    try {
      MyLib.myWaitingWidget(context);

//creating API call
      response = await ApiBackend.forgotPasswordRequest(email);
      Navigator.pop(context);
    } on NoInternetException catch (e) {
      Navigator.pop(context);
      MyLib.myToast(e.message);
      return;
    } on UnknownException catch (e) {
      Navigator.pop(context);
      MyLib.mySnackbar(context, e.message);
      return;
    } on Exception catch (e) {
      Navigator.pop(context);
      MyLib.mySnackbar(context, e.toString().split(": ")[1]);
      return;
    }

    ///on sucessfull response
    ///take back to login page
    Navigator.pop(context);
    MyLib.myToast(response);
  }
}
