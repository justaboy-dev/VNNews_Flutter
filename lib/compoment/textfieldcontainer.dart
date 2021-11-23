import 'package:flutter/material.dart';
import 'package:vnnews/compoment/constrant.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPading),
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPading, vertical: kDefaultPading / 2),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: kLightRed, borderRadius: BorderRadius.circular(30)),
      child: child,
    );
  }
}
