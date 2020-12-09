import 'package:flutter/material.dart';

class BrandIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: new TextSpan(
            style: new TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
            children: <TextSpan>[
              new TextSpan(text: "New", style: new TextStyle(color: Color.fromRGBO(24, 29, 61, 1))),
              new TextSpan(text: "App", style: new TextStyle(color: Color.fromRGBO(75, 122, 252, 1))),
            ]
        )
    );
  }
}
