import 'package:flutter/material.dart';
import 'package:gsgflutter/theme.dart';

class ResetForm extends StatefulWidget {
  ResetForm({Key? key, required this.emailController}) : super(key: key);
  TextEditingController emailController;
  @override
  _ResetFormState createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: widget.emailController,
        decoration: const InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyle(color: kTextFieldColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor))),
      ),
    );
  }
}
