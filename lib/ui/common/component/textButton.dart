import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {

  TextButton({
    this.onPress,
    this.text
  });

  final VoidCallback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      minWidth: MediaQuery.of(context).size.width,
      height: 45,
      color: Color.fromRGBO(75, 122, 252, 1),
      child: Text(text,style: TextStyle(fontSize: 17, color: Colors.white),),
    );
  }
}
