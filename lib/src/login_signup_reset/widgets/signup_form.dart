import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsgflutter/src/utility/theme.dart';

class SignUpForm extends StatefulWidget {
  TextEditingController fname, lname, email, phone, pass, confpass;
  SignUpForm(
      {Key? key,
      required this.fname,
      required this.lname,
      required this.email,
      required this.phone,
      required this.pass,
      required this.confpass})
      : super(key: key);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputFormName('First Name', widget.fname),
        buildInputFormName('Last Name', widget.lname),
        buildInputForm('Email', false, widget.email),
        buildInputFormPhone('Phone', false, widget.phone),
        buildInputFormPass('Password', true, widget.pass),
        buildInputFormcpass('Confirm Password', true, widget.confpass),
      ],
    );
  }

  Padding buildInputForm(
      String hint, bool pass, TextEditingController editingController) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: editingController,
          obscureText: pass ? _isObscure : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: kTextFieldColor),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
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
                          ))
                : null,
          ),
        ));
  }

  Padding buildInputFormPass(
      String hint, bool pass, TextEditingController editingController) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: editingController,
          obscureText: pass ? _isObscure1 : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: kTextFieldColor),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure1 = !_isObscure1;
                      });
                    },
                    icon: _isObscure1
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ))
                : null,
          ),
        ));
  }

  Padding buildInputFormcpass(
      String hint, bool pass, TextEditingController editingController) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: editingController,
          obscureText: pass ? _isObscure2 : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: kTextFieldColor),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure2 = !_isObscure2;
                      });
                    },
                    icon: _isObscure2
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ))
                : null,
          ),
        ));
  }

  Padding buildInputFormPhone(
      String hint, bool pass, TextEditingController editingController) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          controller: editingController,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: kTextFieldColor),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
          ),
        ));
  }

  Padding buildInputFormName(
      String hint, TextEditingController editingController) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          controller: editingController,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: kTextFieldColor),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
          ),
        ));
  }
}
