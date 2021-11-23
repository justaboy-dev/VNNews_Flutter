import 'package:flutter/material.dart';
import 'package:vnnews/compoment/constrant.dart';
import 'package:vnnews/compoment/textfieldcontainer.dart';

class RoundedPassword extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  const RoundedPassword({
    Key? key,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  State<RoundedPassword> createState() => _RoundedPasswordState();
}

class _RoundedPasswordState extends State<RoundedPassword> {
  bool isVisible = true;

  void togglePassword() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
      obscureText: isVisible,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          icon: const Icon(
            Icons.lock,
            color: kDarkRed,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: kDarkRed,
            ),
            onPressed: togglePassword,
          ),
          border: InputBorder.none),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Không được để trống";
        }
        if (value.length < 6) {
          return "Mật khẩu phải lớn hơn 6 ký tự";
        }
        return null;
      },
    ));
  }
}
