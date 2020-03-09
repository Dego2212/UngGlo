import 'package:dego1234/utility/my_style.dart';
import 'package:dego1234/widget/my_service.dart';
import 'package:dego1234/widget/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// Field

  bool status = true;

// Method

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();
    if (firebaseUser != null) {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (BuildContext buildContext) {
        return Myservice();
      });
      Navigator.of(context).pushAndRemoveUntil(route, (Route<dynamic> route) {
        return false;
      });
    } else {
      setState(() {
        status = false;
      });
    }
  }

  Widget showProcess() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

// mySizebox คือ ช่องว่างระหว่างปุ่ม Sign in กับ Sign Up
  Widget mySizebox() {
    return SizedBox(
      width: 5.0,
    );
  }

  Widget signUpButton() {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: MyStyle().darkColor),
        child: Text(
          'Sign Up',
          style: TextStyle(color: MyStyle().darkColor),
        ),
        onPressed: () {
          print('Your click signup');

          MaterialPageRoute route =
              MaterialPageRoute(builder: (BuildContext buildContext) {
            return Register();
          });
          Navigator.of(context).push(route);
        },
      ),
    );
  }

  Widget signInButton() {
    return Expanded(
      child: RaisedButton(
        color: MyStyle().darkColor,
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget showButton() {
    return Container(
      width: 250.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          signInButton(),
          mySizebox(),
          signUpButton(),
        ],
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: 250.0,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(hintText: 'password :'),
      ),
    );
  }

  Widget userForm() {
    return Container(
      width: 250.0,
      child: TextField(
        decoration: InputDecoration(hintText: 'user :'),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      height: 120.0,
      width: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Dego GLO',
      style: GoogleFonts.tradeWinds(
          textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: MyStyle().darkColor,
        fontSize: 30.0,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status ? showProcess() : mainContent(),
    );
  }

  Container mainContent() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: <Color>[Colors.white, MyStyle().primarycolor],
          radius: 1.0,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            showLogo(),
            showAppName(),
            userForm(),
            passwordForm(),
            showButton(),
          ],
        ),
      ),
    );
  }
}
