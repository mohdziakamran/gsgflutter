import 'package:flutter/material.dart';
import 'package:gsgflutter/src/login_signup_reset/screens/reset_password.dart';
import 'package:gsgflutter/src/login_signup_reset/screens/signup.dart';
import 'package:gsgflutter/src/login_signup_reset/widgets/login_form.dart';
import 'package:gsgflutter/src/login_signup_reset/widgets/primary_button.dart';
import 'package:gsgflutter/src/model/user_model.dart';
import 'package:gsgflutter/src/utility/backend/api_backend.dart';
import 'package:gsgflutter/src/utility/my_lib.dart';
import 'package:gsgflutter/src/utility/theme.dart';
import 'package:validators/validators.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LigInScreenState createState() => _LigInScreenState();
}

class _LigInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController(),
      passController = TextEditingController();
  bool _isObscure = true;

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
                            builder: (context) => SignUpScreen(
                              email: emailController,
                            ),
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
              LogInForm(
                emailComntroller: emailController,
                passComntroller: passController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(
                                  emailController: emailController,
                                )));
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
                  buttonText: "Log In",
                  ontapaction: loginAction,
                ),
              ),

              ///Incase needed in future
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

  ///On Tap Login Button Action Method
  ///1. self validate and snackbar
  ///2. API call
  ///3. sucess->pop / fail->snackbar(Invalid Credentials)
  Future<void> loginAction() async {
    String email = emailController.text;
    String pass = passController.text;

    if (email.isEmpty || pass.isEmpty) {
      // MyLib.myToast("Fill above fields");
      MyLib.mySnackbar(context, "Fill above fields");
      return;
    }
    if (!isEmail(email)) {
      MyLib.mySnackbar(context, "Invalid Email");
      return;
    }
    if (isAlpha(pass) || isNumeric(pass) || pass.length < 8) {
      MyLib.mySnackbar(
          context, "Passwprd must be Alpha numeric.\nand atleast 8 char long.");
      return;
    }

    ///-->
    try {
      MyLib.myWaitingWidget(context);

      ///Send request to login api
      await ApiBackend.sendLoginRequest(
          emailController.text, passController.text);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      MyLib.mySnackbar(context, 'Invalid Credentials');
      return;
    }

    ///on sucessfull response
    ///take into the App review page
    Navigator.pop(context);
    User user = await ApiBackend.getUserFromSharedPref();
    MyLib.myToast("Welcome ${user.name}");
  }
}
