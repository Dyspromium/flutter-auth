import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:odyssey/configs/api_config.dart';
import 'package:odyssey/ui/pages/home.dart';
import 'package:odyssey/ui/pages/auth/signin.dart';

import 'package:odyssey/ui/partials/brandIcon.dart';
import 'package:odyssey/ui/partials/inputField.dart';

class NewAccount extends StatefulWidget {
  @override
  _NewAccountState createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {

  Widget failedBox = Container();

  createAccount(String username, String email, String password) async {
    var map = Map<String, dynamic>();
    map['password'] = password;
    map['username'] = username;
    map['email'] = email;
    var jsonData;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post(api.register, body:map);
    jsonData = json.decode(response.body);
    print(jsonData);
    if(passwordController.text != passwordRepeatController.text){
      setState(() {
        failedBox = Column(
          children: [
            Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: Color.fromRGBO(255, 118, 117, 1)
                    ),
                    borderRadius: BorderRadius.circular(3)
                ),
                child: Center(child: Text('Password doesn\'t match',
                  style: TextStyle(color: Color.fromRGBO(255, 118, 117, 1)),))
            ),
            SizedBox(height: 50,),
          ],
        );
      });
    }
    else if(jsonData['status'] == "ok"){
      setState(() {
        sharedPreferences.setString("token", jsonData['data']['token']);
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
                child: Center(child: Text(jsonData['message'], style: TextStyle(color: Color.fromRGBO(255, 118, 117, 1)),))
            ),
            SizedBox(height: 50,),
          ],
        );
      });
    }
  }


  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordRepeatController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
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
                    SizedBox(height: 80,),

                    BrandIcon(),
                    SizedBox(height: 80,),
                    Text(
                      "You want to join us ?",
                      style: TextStyle(color: Color.fromRGBO(24, 29, 61, 1), fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "We're just going to need some information...",
                      style: TextStyle(color: Color.fromRGBO(24, 29, 61, 1), fontSize: 15),
                    ),
                    SizedBox(height: 50,),
                    InputField(controller: usernameController,hintText: "Username",icon: Icon(Icons.person),obscureText: false),
                    InputField(controller: emailController,hintText: "Email",icon: Icon(Icons.email),obscureText: false),
                    InputField(controller: passwordController,hintText: "Password",icon: Icon(Icons.https),obscureText: true),
                    InputField(controller: passwordRepeatController,hintText: "Confirm Password",icon: Icon(Icons.email),obscureText: true),
                    SizedBox(height: 50,),
                    failedBox,
                    MaterialButton(
                      onPressed: () {
                        createAccount(usernameController.text, emailController.text, passwordController.text);
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      height: 45,
                      color: Color.fromRGBO(75, 122, 252, 1),
                      child: Text("CREATE ACCOUNT",style: TextStyle(fontSize: 17, color: Colors.white),),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            )
                        );
                      },
                      child: Text(
                        "Already have an account ?",
                        style: TextStyle(color: Color.fromRGBO(24, 29, 61, 1), fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
