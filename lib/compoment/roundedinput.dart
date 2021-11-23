import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:vnnews/compoment/constrant.dart';
import 'package:vnnews/compoment/textfieldcontainer.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput(
      {Key? key,
      required this.icon,
      required this.hintText,
      required this.onChange})
      : super(key: key);

  final IconData icon;
  final String hintText;
  final ValueChanged<String> onChange;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChange,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kDarkRed,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            border: InputBorder.none),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Không được trống";
          }
          if (EmailValidator.validate(value)) {
            return null;
          } else {
            return "Vui lòng điền email hợp lệ";
          }
        },
      ),
    );
  }
}
