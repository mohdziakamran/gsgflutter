import 'package:flutter/material.dart';
import 'package:gsgflutter/theme.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  void Function()? ontapaction;
  PrimaryButton({required this.buttonText, required this.ontapaction});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ontapaction,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: kPrimaryColor),
        child: Text(
          buttonText,
          style: TextStyle(color: kWhiteColor),
        ),
      ),
    );
  }
}
