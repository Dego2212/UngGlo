import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:dego1234/utility/my_style.dart';
import 'package:dego1234/utility/normal_dialog.dart';
import 'package:dego1234/widget/my_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  File file;
  String name, email, password, urlPhoto;

  // Method
  Widget nameForm() {
    Color color = Colors.purple;

    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        onChanged: (String string) {
          name = string.trim();
        },
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
        keyboardType: TextInputType.emailAddress,
        onChanged: (String string) {
          email = string.trim();
        },
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
        onChanged: (String string) {
          password = string.trim();
        },
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
      child: file == null ? Image.asset('images/avatar.png') : Image.file(file),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget registerButton() {
    return IconButton(
      tooltip: 'Upload to Firebase',
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (file == null) {
          normalDialog(
              context, 'Non Choose Avarar', 'Please tap Camera or Grallery');
        } else if (name == null ||
            name.isEmpty ||
            email == null ||
            email.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'Have Space', 'Please fill Every Blank');
        } else {
          registerFirebase();
        }
      },
    );
  }

  Future<void> registerFirebase() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((response) {
      print('Register Success');
      uploadAvatar();
    }).catchError((error) {
      String title = error.code;
      String message = error.message;
      normalDialog(context, title, message);
    });
  }

  Future<void> uploadAvatar() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    Random random = Random();
    int randomNumber = random.nextInt(100000);

    if (file != null) {
      StorageReference storageReference =
          firebaseStorage.ref().child('Avatar/avatar$randomNumber.jpg');
      StorageUploadTask storageUploadTask = storageReference.putFile(file);

      urlPhoto =
          await (await storageUploadTask.onComplete).ref.getDownloadURL();
      print('urlPhoto = $urlPhoto');

      setupNameAnPhoto();
    }
  }

  Future<Void> setupNameAnPhoto() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    userUpdateInfo.photoUrl = urlPhoto;
    firebaseUser.updateProfile(userUpdateInfo);

    MaterialPageRoute route = MaterialPageRoute(builder: (BuildContext) {
      return Myservice();
    });
    Navigator.of(context).pushAndRemoveUntil(route, (Route<dynamic> route){return false;});
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
