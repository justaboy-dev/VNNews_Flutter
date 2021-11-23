import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:vnnews/compoment/constrant.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.onPress,
    required this.text,
  }) : super(key: key);

  final VoidCallback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPading),
      child: AnimatedButton(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.8,
        isReverse: true,
        borderColor: kDarkRed,
        selectedTextColor: Colors.white,
        borderRadius: 30,
        borderWidth: 1,
        selectedBackgroundColor: kLightRed.withOpacity(0.7),
        backgroundColor: Colors.white,
        text: text,
        onPress: onPress,
        textStyle: const TextStyle(
            color: kDarkRed,
            fontSize: kDefaultFontSize + 10,
            fontFamily: "Anton",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
