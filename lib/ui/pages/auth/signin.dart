import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:odyssey/configs/api_config.dart';
import 'package:odyssey/ui/pages/home.dart';
import 'package:odyssey/ui/pages/auth/newaccount.dart';

import 'package:odyssey/ui/partials/inputField.dart';
import 'package:odyssey/ui/partials/textButton.dart';
import 'package:odyssey/ui/partials/brandIcon.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  SharedPreferences sharedPreferences;
  Widget failedBox = Container();
  bool stayLogged = false;


  @override
  void initState(){
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token")!=null && sharedPreferences.getString("stayLogged")=="true"){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home()), (route) => false);
    }
  }

  signIn(String username, String password) async {

    var map = Map<String, dynamic>();
    map['password'] = password;
    map['username'] = username;
    var jsonData;
    sharedPreferences = await SharedPreferences.getInstance();
    var res = await http.post(api.login, body:map);
    jsonData = json.decode(res.body);
    if(jsonData['status'] == "ok"){
      setState(() {
        sharedPreferences.setString("token", jsonData['data']['token']);
        sharedPreferences.setString("stayLogged", "$stayLogged");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home()), (route) => false);
      });
    }
    else{
      setState(() {
        failedBox = Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color:  Color.fromRGBO(255, 118, 117, 1)
                ),
                borderRadius: BorderRadius.circular(3)
              ),
                child: Center(child: Text('Wrong password and/or Username', style: TextStyle(color: Color.fromRGBO(255, 118, 117, 1)),))
            ),
            SizedBox(height: 50,),
          ],
        );
      });
    }
  }

  //InputController
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final node = FocusScope.of(context);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          body: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottom),
              child: Padding(
                padding: EdgeInsets.fromLTRB(30,0,30,0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 130,),
                    BrandIcon(),
                    SizedBox(height: 80,),
                    Text(
                      "Sign In",
                      style: TextStyle(color: Color.fromRGBO(24, 29, 61, 1), fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NewAccount(),
                            )
                        );
                      },
                      child: Text(
                        "You don't have an account ?",
                        style: TextStyle(color: Color.fromRGBO(24, 29, 61, 1), fontSize: 15),
                      ),
                    ),
                    InputField(
                      controller: usernameController,
                      hintText: "Username",
                      icon: Icon(Icons.person),
                      obscureText: false,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    InputField(
                        controller: passwordController,
                        hintText: "Password",
                        icon: Icon(Icons.https),
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () => node.unfocus(),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: stayLogged,
                              onChanged: (newValue) {
                                setState(() {
                                  stayLogged = newValue;
                                });
                              }, //  <-- leading Checkbox
                            ),
                            Text("Keep me logged in"),
                          ],
                        ),
                        Text("Forgot Password ?")
                      ],
                    ),
                    SizedBox(height: 20,),

                    failedBox,
                    TextButton(onPress: () {
                      signIn(usernameController.text, passwordController.text);
                    },text: "SIGN IN"),
                    SizedBox(height: 15,),

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
