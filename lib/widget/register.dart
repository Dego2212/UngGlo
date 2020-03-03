import 'dart:io';

import 'package:dego1234/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  File file;

  // Method
  Widget nameForm() {
    Color color = Colors.purple;

    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        decoration: InputDecoration(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color)),
            icon: Icon(
              Icons.face,
              size: 36.0,
              color: color,
            ),
            helperText: 'Type Your Name in Blank',
            helperStyle: TextStyle(color: color),
            labelText: 'Display Name :',
            labelStyle: TextStyle(color: color)),
      ),
    );
  }

  Widget emailForm() {
    Color color = Colors.teal;

    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        decoration: InputDecoration(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color)),
            icon: Icon(
              Icons.email,
              size: 36.0,
              color: color,
            ),
            helperText: 'Type Your Email in Blank',
            helperStyle: TextStyle(color: color),
            labelText: 'Display Email :',
            labelStyle: TextStyle(color: color)),
      ),
    );
  }

  Widget passwordForm() {
    Color color = Colors.orangeAccent;

    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        decoration: InputDecoration(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color)),
            icon: Icon(
              Icons.face,
              size: 36.0,
              color: color,
            ),
            helperText: 'Type Your Password in Blank',
            helperStyle: TextStyle(color: color),
            labelText: 'Display Password :',
            labelStyle: TextStyle(color: color)),
      ),
    );
  }

  Widget cameraButton() {
    return IconButton(
      icon: Icon(
        Icons.add_a_photo,
        size: 36.0,
        color: MyStyle().darkColor,
      ),
      onPressed: () {
        chooseImageThread(ImageSource.camera);
      },
    );
  }

  Future<void> chooseImageThread(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

     setState(() {
       file = object;

     });

    } catch (e) {}
  }

  Widget galleryButton() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 36.0,
        color: MyStyle().primarycolor,
      ),
      onPressed: () {
        chooseImageThread(ImageSource.gallery);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showAvatar() {
    return Container(
      child: file == null  ? Image.asset('images/avatar.png') : Image.file(file) ,
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget registerButton() {
    return IconButton(
      tooltip: 'Upload to Firebase',
      icon: Icon(Icons.cloud_upload),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[registerButton()],
        title: Text('Register'),
        backgroundColor: MyStyle().darkColor,
      ),
      body: ListView(
        children: <Widget>[
          showAvatar(),
          showButton(),
          nameForm(),
          emailForm(),
          passwordForm(),
        ],
      ),
    );
  }
}