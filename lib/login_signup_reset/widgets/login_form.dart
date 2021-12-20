import 'package:flutter/material.dart';
import 'package:gsgflutter/theme.dart';
import 'package:validators/validators.dart';

class LogInForm extends StatefulWidget {
  TextEditingController emailComntroller;
  TextEditingController passComntroller;

  LogInForm(
      {Key? key, required this.emailComntroller, required this.passComntroller})
      : super(key: key);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('Email', false, widget.emailComntroller, true),
        buildInputForm('Password', true, widget.passComntroller, false),
      ],
    );
  }

  Padding buildInputForm(String label, bool pass,
      TextEditingController textEditingController, bool isEmailField) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: textEditingController,
        validator: (isEmailField)
            ? ((val) => !isEmail(val!) ? "Invalid Email" : null)
            : ((val) => !isAlphanumeric(val!) && val.length < 8
                ? "Type Alpha numeric password.\npassword must be 8 char long."
                : null),
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
      ),
    );
  }
}
