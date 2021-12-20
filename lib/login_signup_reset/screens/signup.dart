import 'package:flutter/material.dart';
import 'package:gsgflutter/backend/api_backend.dart';
import 'package:gsgflutter/login_signup_reset/widgets/primary_button.dart';
import 'package:gsgflutter/login_signup_reset/widgets/signup_form.dart';
import 'package:gsgflutter/theme.dart';
import 'package:gsgflutter/mylib/my_lib.dart';
import 'package:validators/validators.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, required this.email}) : super(key: key);
  TextEditingController email;
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fname = TextEditingController(),
      lname = TextEditingController(),
      phone = TextEditingController(),
      pass = TextEditingController(),
      confpass = TextEditingController();
  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blueGrey;
  }

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
            const SizedBox(
              height: 50,
            ),
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
                      Navigator.pop(context);
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
              child: SignUpForm(
                confpass: confpass,
                email: widget.email,
                fname: fname,
                lname: lname,
                pass: pass,
                phone: phone,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                "*the password Should be atleast 8 charecter long and must be alphaNumeric",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    const Text('Agree to terms and conditions.'),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: PrimaryButton(
                buttonText: 'Sign Up',
                ontapaction: signUpAction,
              ),
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

  void signUpAction() {
    if (!isChecked) {
      MyLib.mySnackbar(context, "Please check the box above");
      return;
    }
    String em = widget.email.text,
        fn = fname.text,
        ln = lname.text,
        ph = phone.text,
        ps = pass.text,
        cps = confpass.text;

    if (em.isEmpty ||
        fn.isEmpty ||
        ln.isEmpty ||
        ph.isEmpty ||
        ps.isEmpty ||
        cps.isEmpty) {
      MyLib.mySnackbar(context, "Please fill mandetory field");
      return;
    }
    if (isAlpha(ps) || isNumeric(ps) || ps.length < 8) {
      MyLib.mySnackbar(
          context, "Passwprd must be Alpha numeric.\nand atleast 8 char long.");
    }
    if (ps != cps) {
      MyLib.mySnackbar(context, "Password and Confirm Password should be same");
      return;
    }

    ///if all check pass Make API Call
    ApiBackend.creatAccountRequest();

    ///On sucess response take it to login page
    Navigator.pop(context);
    print("compleated signupaction");
  }
}
