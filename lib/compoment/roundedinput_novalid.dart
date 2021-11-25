import 'package:flutter/material.dart';
import 'package:vnnews/compoment/constrant.dart';
import 'package:vnnews/compoment/textfieldcontainer.dart';

class RoundedInputNormal extends StatelessWidget {
  const RoundedInputNormal(
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
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: kDefaultFontSize),
            border: InputBorder.none),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Không được trống";
          }
        },
      ),
    );
  }
}
