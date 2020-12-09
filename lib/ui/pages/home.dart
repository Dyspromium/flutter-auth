import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:odyssey/ui/pages/auth/signin.dart';

import 'package:odyssey/ui/partials/textButton.dart';

class Home extends StatelessWidget {

  disconnect() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30,0,30,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Vous etes connecté"),
                  TextButton(onPress: (){
                    disconnect();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SignIn()), (route) => false);
                  },text: "DECONNEXION",)
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
