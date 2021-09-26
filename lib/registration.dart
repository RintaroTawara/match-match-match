import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'authentication_error.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String newEmail ="";
  String newPassword = "";
  String infoText = "";
  int? genderId;
  List<String> listOfGenders = ["女性", "男性"];
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
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: DropdownButtonFormField(
                items: listOfGenders.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value)
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == "女性") {
                    genderId = 1;
                  } else if (value == "男性") {
                    genderId = 2;
                  }
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
                      await FirebaseFirestore.instance.collection('userAccounts').add(
                          {
                            "uid": user!.uid,
                            "email": user!.email,
                            "genderId": genderId
                          });
                      Navigator.pushNamedAndRemoveUntil(context, "/user_account_list", (Route<dynamic> route) => false);
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
