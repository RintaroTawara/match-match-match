import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_matching_app/user_account_list_page.dart';
import 'authentication_error.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String newEmail ="";
  String newPassword = "";
  String infoText = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  final authError = AuthenticationError();
  User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  newEmail = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "パスワード(8~20文字)"),
                obscureText: true,
                maxLength: 20,
                maxLengthEnforcement: MaxLengthEnforcement.none,
                onChanged: (String value) {
                  newPassword = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
              child: Text(
                infoText,
                style: TextStyle(
                  color: Colors.red
                ),
              ),
            ),
            SizedBox(
                width: 350.0,
                child: ElevatedButton(
                  child: Text(
                    '登録',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white
                  ),
                  onPressed: () async {
                    try {
                      UserCredential result =
                          await auth.createUserWithEmailAndPassword(
                        email: newEmail,
                        password: newPassword,
                      );
                      user = result.user;
                      await FirebaseFirestore.instance.collection('user_accounts').add(
                          {
                            "uid": user!.uid,
                            "email": user!.email
                          });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserAccountListPage()));
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        infoText = authError.registerErrorMsg(e.code);
                      });
                    }
                  },
                )
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 350.0,
              child: ElevatedButton(
                child: Text(
                  'ログインする',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[50],
                    onPrimary: Colors.blue
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            )
          )
        ],
      ),
    );
  }
}
