import 'package:dego1234/utility/my_style.dart';
import 'package:dego1234/widget/authen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Myservice extends StatefulWidget {
  @override
  _MyserviceState createState() => _MyserviceState();
}

class _MyserviceState extends State<Myservice> {
  // field

  String nameLogin, emailLogin, urlAvatarLogin;

//method

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<void> findUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();
    setState(() {
      nameLogin = firebaseUser.displayName;
      emailLogin = firebaseUser.email;
      urlAvatarLogin = firebaseUser.photoUrl;
    });
  }

  Widget showAvartar() {
    return urlAvatarLogin == null
        ? Image.network(MyStyle().urlAvatar)
        : showNetworkAvatar();
  }

  Widget showNetworkAvatar() {
    return ClipOval(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(urlAvatarLogin), fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget menuSignOut() {
    return ListTile(
      onTap: () {
        processSignOut();
      },
      subtitle: Text('Sign Out and Back to Authentication'),
      title: Text('sign Out'),
      leading: Icon(
        Icons.exit_to_app,
        size: 36.0,
        color: Colors.red,
      ),
    );
  }

  Future<void> processSignOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut().then((response) {
      MaterialPageRoute route = MaterialPageRoute(builder: (value) => Authen());
      Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
    });
  }

  Widget showHead() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/wall.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      accountName: showname(),
      accountEmail: showEmail(),
      currentAccountPicture: showAvartar(),
    );
  }

  Text showEmail() {
    return emailLogin == null
        ? Text('Email', style: TextStyle(color: MyStyle().darkColor))
        : Text('$emailLogin Login',
            style: TextStyle(color: MyStyle().darkColor));
  }

  Text showname() {
    return nameLogin == null
        ? Text('Login', style: TextStyle(color: MyStyle().darkColor))
        : Text('$nameLogin Login',
            style: TextStyle(color: MyStyle().darkColor));
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHead(),
          menuSignOut(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text('My Service'),
        backgroundColor: MyStyle().primarycolor,
      ),
    );
  }
}
